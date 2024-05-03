Return-Path: <linux-btrfs+bounces-4729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D68BAD3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5D21F21622
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCDD153590;
	Fri,  3 May 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eoIbuTqB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ai7cVZWa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8B1BF24
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741867; cv=fail; b=mAPWPiMFXrqdMvG8RdjJWTmjxxfVisNxcsrjeTn2R8fnbNbZbYUZBrzrNOalDlZqWw8rPQf13Rlb11Y9b2zTSKSkWFKiRmQM5gYtHV1OPabOofrgmjl/ggSSxWw8F2N0V1e3RkZhU8DwupF0ZOQzC2Dlur+S6lzFj3eRNJSO6TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741867; c=relaxed/simple;
	bh=ddKezfQDdZdtIiFPAS5bBpumVxPn4glm3kQ73f8t7dA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrxUtTRWPhJ31YZA9FN3ZpSDnIUjXPukoP2aP7gXUphO/43vtlbKFmZN46NYA8TrCen4DJbaGyTuiigiWwivQVFv2DW37TvDrtJETPzjx+g+UedCeSX6j9RUjFQjuJ0rWjSZ3rRrHpsWTg+yDTAPqMnFjBvgbh3NXEkSNGNim2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eoIbuTqB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ai7cVZWa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C3Dt8029637;
	Fri, 3 May 2024 13:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fQfhdzmgdJ2tArmaN3WqAzhHKZX6EfvIIflSph68hsU=;
 b=eoIbuTqBro3nqaW4uBSwSppZXM/qZUJ/iz9s/lbX9A51ef8W7BVrtOsCGiQLLj57QuMR
 uQRkxrv5RfG0wro562GCHVIYfjQH5R/XHLu8ojMVYDhY/1G7gJBC+K1S88rNXJ2YdwPH
 3j/5n+IC94+EYfLgT5hN9vJbS9KPhoTRuTJm09Os9g4+DlmlQd+RujamYR/eKiH6FQjb
 dNj/3HYU+AAW3Gfta8W8wGiB9+Q/fYxOJcXTP5FaUSoggVjczsC7jCHf4BdYhERuN4ol
 OP5m13O7+udIY4Y7+2xfUicLMN3NH6J9NLyltCySqz9Xdh+w/esATCgLTyPcqCs03Bj1 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryvgrbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 13:10:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443BiPrp040073;
	Fri, 3 May 2024 13:10:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcgxf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 13:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxGzx5Xn/p6dg1j3yoEw6eynZH2RUnKCSoKZtgHjC8EndrtILtZHh6fT0KseWu7gtxzzffIiMjcSM4LADwONzr2wiFnbBjHnbbN7SsmV85LqVdRdxEzsJ29jkpVYH135UnUC9YbDnRDG+4v+d/wh/BbDzJAEkX8cex+5zKwg2K67yhNAUUn+6qGqT0MMMdegg+i1RY5tM0ifjtpBAeQz9ifgk5Qtil9Hlak8WJdbzbJja++7LgtameRi9no0lPL3SzBBuLLvKVRCbn1WI7CVOvi9SJWPLoQCL0R4WYMW+BRGOV0ebtKi2EqWZ38YkStf51Z/uUKPwwUMb62+fKroGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQfhdzmgdJ2tArmaN3WqAzhHKZX6EfvIIflSph68hsU=;
 b=DOq2+xsGbW6KneQvQpa3q1KAosNGC4FxmQBCnDc86HKKUZ9qVnwXZIFU8k2jOjthlbTc6+dd0Z+ap0qwy1r5c9PNA9kRiQkZVLCgO03abPJ23WXP5qBmPcO8aJqZXkVPUIDgywmwLZaL7SSVNHMdcVqe5MztPV+kFrTSAMtrIfjG6V+B8WBOS22wuEgfMHbd13BjsqQ8Bwfkdf7lpCmPeSvRaUoBZDOpu/Tq8nOCLgMlPUwC/MpY0X2Lo34ldRReo+l4unxjKbKy/2/GGMWuA6C5LadZhnl8V1wHr39DgN0ozl5AYWH1dqqNH/a4mv1Pfb7FiLwPBFkHS5rY/v/aRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQfhdzmgdJ2tArmaN3WqAzhHKZX6EfvIIflSph68hsU=;
 b=Ai7cVZWaX0u3IJQsMo0EcGVdi1EiRn1Z3FKB5ZmjmIVLbxxguQS27hpszwV5TiRdBwAUZVBX7EABh22mAPPp4OZd/5R1WbTzZtBqGZhgnuFBT5nLK5H5R2EKZJlkxuJEkobSR88xY7aaOQ7Um+gq18SzDzV9xjBbKzSZhATnTeE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5046.namprd10.prod.outlook.com (2603:10b6:408:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 13:10:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 13:10:55 +0000
Message-ID: <8026d42f-21e1-4175-bb52-73b4b347cbd9@oracle.com>
Date: Fri, 3 May 2024 21:10:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs-progs: convert: refactor
 __btrfs_record_file_extent to add a prealloc flag
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <c4b3a3a5192fe56f7b2e1d1ec91046ec27eb1a02.1714722726.git.anand.jain@oracle.com>
 <20240503115059.GX2585@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 xsFNBGQG2+MBEAC42714sRj0ptcjHWMJgkltgglCKCpcjdLTyoFY9dljqJdvrOeojl4N1Ztb
 qMwsnsoFkPiVMUnnU/FgypRlPOzaB4w0R9MTzfvpHKAUNMbaYLquldGJhfuYpTgikr5GztZU
 VGKGsKc4NJzWh6Mfqit2jwurS18RmjxR2dBDKKb5+M5xQ66M5Of2SuuzaM6UnT1vctDN/hWr
 MDqx3CNeQ8Va0i1iCStsdS3ExG6nBVZkL9ZCHHZHi/oqe4bG4vvevRlx57s+uS4WKpAsjlKD
 Z/WHxer9bffB9GuOCngrOTWiXtf1qmgXNs5kXlfb6O3uRv1xnfqTAHdxJ8/pwSShl2aDScdW
 7S265QZ92+ygEJeoviTc8FyrhKkV5c4hAMa9QeiuP6Sk7Mk1G0D/d/DlHQCncQZ/St6q5ESX
 M1LbFLp4amx2yELX0/2lLBXj5s0vQd4mbyz29K5TfiYB/BsEWzSA0gTM9MPdJL3FhIei5VsD
 SQ197dkp3pzqII7/rw77sQs6TFin555Q4DSMsKvKvm/vULpknXMe0DdrHw8ybrY2AjWiTs2W
 1Re7VPORkKxEK7prZ62hghiEvGyZHh0RpnI0aD57R8P3RLJ5P7mCMKimK46SC9fw+zWfWZJA
 EIDccuxTfaLdGPMO8GJ2HnKbvAFbI+nMoSYRvJ6ULvcsH9bPPwARAQABzTJBbmFuZCBTdXZl
 ZXIgSmFpbiAoT3JhY2xlKSA8YW5hbmQuamFpbkBvcmFjbGUuY29tPsLBmAQTAQgAQhYhBKPX
 ZMgfwKRZ10YTjD2+pVga3ljYBQJkBtvjAhsDBQkSzAMABQsJCAcCAyICAQYVCgkICwIEFgID
 AQIeBwIXgAAKCRA9vqVYGt5Y2EAVD/98XUcG+lHTLFvrBn/l+egW5BiJUiUuLIti9wMmj3lg
 Ndv6myanBwjK+v0+RZJ6Vr+oazwTiki6RgnxT3LN9u79T4C7vGuVjqZ205a1vGVN309oMPDm
 +rF4qstsNBMTyE6FfLD1n4ONqgMLATRuk5rPAyfIXQyKy5UomLZo+ISHjpDUt4sXnrsYMz/N
 Ht5w7LRQMmKva92T5cReAvyU8guCHTiG6oN3RCQKlyRmZnFCXa2ov+hYhBrpNikFtPOojGnQ
 JZ/i7RHIU7/ku0/NCGLe+3osdjxaItjkcLP6U7R+WrViweSKocwrtqVIlizSvaDv4MxYM2oM
 aHoAcolFcrpUaqgnUAjhwYRc6CNdB5MroTzrzGnacJ4y7xBlql0+HlrlNho2AVLqvXmar5fp
 uwUHYTeUwsixVHfJL+1sow3Ky7Q5SknDQKd7V7X9X1qs862fuuBD3iPLR4YY5SstF1P0lFrr
 QjNS85TaHFkFhKrXGvhe1WGhum5Fc0hVx88gQBZ2gdw8z4GWKC5esxbvv0lI2UhP89q2ClsY
 ZFS0/Odo0eGgfyxqUGtrouK4cMVXVP+LJb168xt6yOuPMTOLJH/CT9/b3LygcWxn4m/2+XbY
 w1aLKoaO1cKAMSObubp1nQIy+idTnQeY69oKQpxYp97EH7bhYBWfLp/kKJEB98hJeM7BTQRk
 BtvjARAA6w/uFi14uDJ1jAlGWYUpBELdj1NgSAWw6CR6GiS9XPlvtn1uApa80cy/Hm1mqYQJ
 FtC+H3Q0uJRZYol2dvDRJYfDmC4bwoO/mru8ZpHVF2c2rVehDvgzxYJeqH9fJi6fymr9rOa6
 tjX0v8FGKD2pnU8yPXsMNeADdl2lL+XPwVoVhAxx8bpotl8nG14TXQcBNuKxbU4oWRjUZif2
 32CAXkngOnE/dwo68L6tfwBaKNCtXXjv7BMXylXjByMciW1hsR+wwOObWioW8R9uQEDWSNv1
 EwXre7VnuIksrt53Ohfuz458eF5Lg6qKGMYYuLmNwRbFPBeZvx6989P2zKuQn3I6YxzA2sdo
 YIhwJHbJNsf971H3CMFORqiLZY9OQ3Ef6FaLW+KM0p9ezuT9bAomQm6xGJDWC93hM/xLXAd7
 LJxhhxj9rQTwSwxm5eQg0ODntYXeEVfJw/gW0eMf5ivTjzKEF22oTswsEKjnsaZ2UZNPi9Pj
 WbPTEWCzGe4jHLqgY70F7f+OgCoI6Qyvb4+UfXyKez+zuo05Q8TxSFa3diFP5/mRokFMzrmF
 lgnUIyPYrHJWAhizZQveSNQ/5M0C9cVykxhaGaF6r0z8JRxhXi0hAlFIDaGye1k+UB8ZoENq
 JVOcjH5uVcXjdqzEXCa9OCDCJrHYCTu+dxyvR6iFXZUAEQEAAcLBfAQYAQgAJhYhBKPXZMgf
 wKRZ10YTjD2+pVga3ljYBQJkBtvjAhsMBQkSzAMAAAoJED2+pVga3ljYwXIP/2B74x/gNE4c
 5/TGzX3oKEdflBGadVjkirOGM1yjIEqstnCF1UIABhyLJYv9IRaNzhx+ieBDD8knEVAAXvp+
 3b0cnmct+kyvOnXwYpCDJSZcJRE25f8fyTyvo17rUCdP8CennzfB0CFMeis7JhyC3b4ZRaLm
 M87gx9ZJA6z5SLarw5zeI5rHmpQ8FK4hGH82AJeedHKcE+RR8rNOyHpdKDHIEtTxWXTZAC+q
 TxCzgLS6y0OOXDGPifcHjSkW7mSrnVXb/FTIqxVC8ClHwSomp2IQLwqPaew+QNFT3RII7QbK
 vQyq+V0TMXGo7zQQ23SN1N08Nj7E6m/hHffFZvRJ1ibZdHaDDCeDXEZoklttj78325i8yV/C
 XDL6MeirxiJyB8P+Y9eSrIDTQP0jKBPQa6N66QeBSJnMFuDBbP82lovdszeCJq5XhwjDgQ3b
 zAKqel0LTK4JTAlKeYjX678eVUcDAkdfurkLDbYcPd6sOveHr1Wuz3aFgtPVVnVzg3rwi5oH
 rffHVDSAu23bB/YgL+OHJ+EzKIqR+qLaYt0Y+e12zhFBSazVC6NFFQY0A+BV7PPnOLdKF1IE
 kbRwSOU3mzvks433LMKj9vmt5TyRU99OsAIn/BY2nCP3FURwQ1NKQ2vpJ8KnkLCGePkjefcQ
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240503115059.GX2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9a177f-d799-4e5d-ca8d-08dc6b727781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YU5yN2t5T0FxWjJSR3dWNnJFVG1vV3o5dEl2NmVTV002NC8wcVF4R1pPaWhQ?=
 =?utf-8?B?TkRwNEJLck1SeGdKdEtkZjNZdDVrMGEwUUVOU3F0TlVMWnhHMFIwenJmUWdp?=
 =?utf-8?B?V1p5RDczeTlnNGdob3ZDOW9KMnZ2eEk5RElhbUhRS2ZLYnBEUWN2UFdUK296?=
 =?utf-8?B?b01YZGRUam5tZGlJM1d1V1hWVzVhbjJXWDFPTklCRkQ0SUp6OGNGWWNYTFRX?=
 =?utf-8?B?U2FiNFdTZ3lvM0duTTZ0dEVTS1QzbUw3Y25uUXM0UTFGbHloSVQxZUJFbVpu?=
 =?utf-8?B?Q3FkZHpYQmYvNWpsb3ZwSWRFOHUzaE5BdHlWUi9zSU8zS3ljbld1YXErNkZ0?=
 =?utf-8?B?d2hxalMzbEJkZFBFcjVGaHZ3TG9Ic09pMDlMWDVHZ0tBcCtZc0JURjh5U0RK?=
 =?utf-8?B?WmRhWThrbWhXRFAyUkdYbm1pODhZSHl3cmVpRW9SZkg1VDBHNmNxVHE1b0o3?=
 =?utf-8?B?KzlFRGJNaFc0ZjN3eVUrVXY0b3hvaFU2amZlRGRmaURwVlpQVmR0Yy9ydU9a?=
 =?utf-8?B?UHZ4V0FIM1NSMzRISTJxTEpWdXkyREg5N2tiV1BvYTlDUjhKaGFiS3lIcEc5?=
 =?utf-8?B?T21xUWdpZHozWElxRXVlUVZpS2ZrVnEvVFQ0T1BvQzNtNHpxaTNOYlRjMVNm?=
 =?utf-8?B?RDBBUTB3dWdQQjF3OEF3SS92RlFxbXZCTFZQZDR2WDRvcURoNXFQWVlEODlq?=
 =?utf-8?B?WWYyMkJlVXdDYWo5emRUb1VsNjQvNDNqeEZMcUc5NG42NEQxbFl1bU1MRk45?=
 =?utf-8?B?M2puZSt3YnRJYUFQUFM2ZjEyanF4MDRqSUtEVVlvakNpRi85YzBWT1hVNW1i?=
 =?utf-8?B?QnVvYjBtN1ljZWNhZ3liMldwcnlubm96clBCdmpGeEd6cmJYNGtTNUMwNjQ4?=
 =?utf-8?B?THF2eGUxZTJZeWZlL2EraXVCdUdwRjI0NjByUHJidTliQ21wWlRzVllZWVha?=
 =?utf-8?B?eGE1Qzd1SGJqQW9GNVYyYkdDYkpsMDB6YzUwdms0TVB6WEtKeXE4Q1NueXdJ?=
 =?utf-8?B?cXQxUlhtWFFrYThhRW1YdVpiZ3lPait4WDRTYTF2T2RqZkJFaTNmWExwRVB4?=
 =?utf-8?B?T1B4STUxQVpGcDFiOHRud0FyZktwL1dtb0JoQVJCcFhsaUo0SU9HTFlPdDAw?=
 =?utf-8?B?aWdBS0xVNzJyMUt0dDJ5OTZRTjN4eFpDa1VsaHZ5VUovOHNDM3RodzFTVGU0?=
 =?utf-8?B?WThtQ0Q0Zk1Ea0tVNUhCSUo1ZWs3ZkkvQWJ6NDI1Ym9KNElzQ1FSQTR5TTJt?=
 =?utf-8?B?U3RCVG9DMnJMUERyY1lldG9Gb0dNTEFkKzd1d1k4dFNSSGJNRDFZdGZaMnRV?=
 =?utf-8?B?L05OTzM5aFNTMVhRbWl6Vk8yNExkakFyY1BROGJNVFk1a1VvRGE4T3QxTnMw?=
 =?utf-8?B?dXdOUHRMN0pMQWVyT29FZUVGNW5laGNlNkkrTHorNUtvcFVIZ0pua0svZUhq?=
 =?utf-8?B?V3ZQMDhxaHhmVG8yOFJZOVZrQ2Qxd0c1YnBodEZEWXlpM0pBTkpRRklDb053?=
 =?utf-8?B?MXBKK2pod1VUaUt5RXEyUzhVVGtnKzcweHpJekJvUEpjaGJSQUQ2NFJwRElP?=
 =?utf-8?B?WEFxb0J4UnNESVdsdzBmYmo4NjBsL3RnUlRzL1E1dDRHMlhoL3NMNUFSQ0h2?=
 =?utf-8?B?ZHpKajNQVDhSVnFnSVhlU3J3ejR0M2J4OThNUDlleVk5SzM4aUZKZ05tSmZs?=
 =?utf-8?B?MlB3VW50L3VYZmdMU1VQVjlQbkNYM1ZkZmtIT295Z0gzdmprbXBVYXZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0RjZUpZK3FjbVU2OWx4S3lYNVJXa0g3MmFRaXowUDlCWWxxQ2ZhT3BmajBv?=
 =?utf-8?B?S0VlY0RBUWt1dlJlZGpIK1RHUmFORnp2cDN4K3RzWXh2bGlBRFVuNDhRYUtj?=
 =?utf-8?B?Wm1lMWNjYVJicHppU3RTTUE4MEQvS0ZtOW5lMWxZOGZ3YU5MakcrQkJrUnRJ?=
 =?utf-8?B?YVFUeHNTNEJZVGYrRVFtdkZ6aGp1cDBCRzhYbnpkYk5WWUh6MldXUnBkelpm?=
 =?utf-8?B?MGNOU1pmZmZ4SGU0bkk2WVNHUE4xVXVnYUxKa2xicTRiZGRhQmZOVloydE1W?=
 =?utf-8?B?c1l5TXY4SUY2a2pSamhiOGpneTJBbTBuNHFCZUh3dlNoTVpSbFRIaTJwS2w1?=
 =?utf-8?B?cnFGMTR5WEU5NTVUM2l5Yy9HMUZGdUVTb21IRk1oWlo5dHAxb2VFMVoyL2t4?=
 =?utf-8?B?bkl2YjlQbFU2UGZTVVg0VnpzYUZzcjRacVRnTlM2MWFjSUk5a1I0dEg0cXQ3?=
 =?utf-8?B?aUpYU1VhWEdIemgvWlNXSHpXU1UyUmpWQUFLOVYxK2kyYzY1WSs0WTIyWTk0?=
 =?utf-8?B?LzVQNk5oeGFqckxTRTFnVHYvN21KbmN2TG1VWUUySjluTVJyaUpKRlo0MnBm?=
 =?utf-8?B?K2dJUmRhNnpOa2tOb3NDMUFtOGZFUm10aXlkWXRrY2swZGk5cXYreTRRaE82?=
 =?utf-8?B?ZVM5S0trcmsvM2g4WFUreXBwZ25xY1g4MitBYmh1Yis3SFR2Rzl4QnExaHhI?=
 =?utf-8?B?YVF5N0ROZ3hOZzJVVzlRM0VPelhndkdCaXQwM2dKZ2Rxa1ptZVd4TTdCb0RW?=
 =?utf-8?B?cis2NHBUL3NLTkc2TWpCTC9pRmRSekpZRmtsRlZIS2FSRVNCS204QUdBNUVm?=
 =?utf-8?B?dDhabXFXZGxDeXVaL1pEZTNzNHdxM0s0cDNkNnRpM0w0QjBqNTNFWnhoMmh1?=
 =?utf-8?B?OHlBcGhWaEU5Y2p1S1F3NmMwbG5SQWRGZllWZ1pkV2J2d3Ywb3d0MEthRXdh?=
 =?utf-8?B?eldhYU52N2VOZW91SW8ydUowWS9KQU5BR0o1TnROckpZZFF3cHBmdVh6dmNa?=
 =?utf-8?B?NVpQVDFqMlhGK1gwcVBodUpDWXRYT3RXb3Jhb0RZSGZPNmpLam1WbFhDTkJu?=
 =?utf-8?B?WnM2b2UyY1Uyb1dGdmQrVUxlVkVoellsWUF2KzdvSlpnKzhndGJaL0xSTVBX?=
 =?utf-8?B?Tk4vZ3dtbGxkdzRJaUcrRlpoUVRoQ255NnljUzVobG1QT0JYdmlDWE55RHpB?=
 =?utf-8?B?QkIwZmNHcDJOcCtNMUkrRXJscVp1SGs4QlNCTFhFSEpkVzBXT1V2SktmQlM5?=
 =?utf-8?B?OUFqd2NtejI3cVExNmtmRFB1K1MvM1lPc2ltVG1nc3hVNGtlRFp2WWpaaVZJ?=
 =?utf-8?B?a0JQVmF4aThxRE0rWHdRYlJmQWdwVjZxYisxdlFueUsxZGJZanNnVzhYajlr?=
 =?utf-8?B?Ri9EdTlJODdQYzRhYWFPQ3RHbkFOUURUeWtwWHhGQXlIMk10STEzbnduS2Iv?=
 =?utf-8?B?NXlFVTBpSlAyT3BkTjJIUkwwMWtsZldENUQzaVA3RlF6WWxoc2xIcmluZXcw?=
 =?utf-8?B?N0xGVWdMNkFpb2dRK2xoOFhNL0JzRkdEUVlveERUODd4Y0pvMjlvNXVETW10?=
 =?utf-8?B?SWRQQnZFeGNNVFVlaEJJTXRpUmhlRXRTNDkzZDBNL21wa1VKRWY4ZzlCL1E5?=
 =?utf-8?B?UGcwanNXZnFNYWo3S29YV2R3S1Z4cFM4SmVUbklOajZjbkdiWjR1dkMyUGRh?=
 =?utf-8?B?VjNUc3VLd1ZOYzVCK0I3eGxMNVg0K2VXOHAvVGJmRWFrWVMzTU82WEFBU1NK?=
 =?utf-8?B?QmdZTlJVUmJvZUYxU1BFK1Z1MVczQUNrc1JGT1pkaG02RFEyQjZQL3VtU1U1?=
 =?utf-8?B?Z1ZoZkNsNVFWSEsvOUdKZGdzSkt2bkIxcmRxSy9ucVIyYU5zYVJ1dkxFYktN?=
 =?utf-8?B?WmtSMjhlM1VZOFU4c24wS3NqMWRJcnVjYVVLbEVlOFlGd3gxNDVUcnkyMUUy?=
 =?utf-8?B?Tm5uYnBMcUp6cjVteE1LWWZQUWNBU1IzOHdMc3BWWjRKL3dzVXlyRTZtZlV1?=
 =?utf-8?B?OFI4dXBTTXlCUVNEWGcwRks1UVZyY0hGY2l5TENIRmR6aGYxRE15UEZTbEFw?=
 =?utf-8?B?V0JYOUVabTVaV3BCbDRRQXdGME9pNFg0bTJPTmkxOXA1UXJ4b01pTjlOendj?=
 =?utf-8?B?aWlQRVc2SWd3SWcyNUVXN0syc3poMnFuVjNiNVNkK0tqODQ1aDRWQnFZZFMz?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AEmDiKUhQKN1RtcbWCKB0spslbx6bcR5+VW8M4nUOU+T6htrcm8gxuwrvvHMd4cBb5psiUIui8Ur/4ViZzMnw+h3OY/WuM1aAxlzG+zDHjHfznaMG+t9OZ7myZiJQe9EUdD9wn9tG9W7mC7flj8PgQq/Ja0szcA669dm31tFZJYTxXCgysfoUh5GqN2+D1Thp3sSma7NpT8/Ulua44jzmEPQThY1K5D+EfBtvg6v7jxssjepWQdPJMGokhqBVCfLApXjIDZKR/FQxYcGhEkJd+JmiyCBai0ZXf43m/ODLsAZKSmiKOlzKQkMULo7VEvLWv/AlS9Mqt67YDVIJ64TwUyq/kbhhBp4GrDJFz7d5Pg41VCCmx5p3XRFhsTCZIT5dYsbUi1eq6OZAxLVtG+JqVgvXjB1Uplft14Z8RS1yByJEqp5WLEgSAh3P5yaJ+OdxOxoZlgRWKi6gBN6ee3X1Vru3ug5az962y6Qmi7BoFkJBB9D20/r+DiUiiStoP5MQcQlmc1FpziYhL/LOJtwUrWtZATK+XPz56qWSm9Ig3YYvvgyJ2thdMLU6QOc325FZU3MIXOmqvno/V8rPv2TBtqd4k7Ha62zJ3yPGkwmkxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9a177f-d799-4e5d-ca8d-08dc6b727781
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 13:10:55.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVXDFM3tm+Lyb/695/0S7pjtBPig9KfElxTkxGEsfLftbnsD1XbW4TdNHXsaBS/VR0t3AtOYiAZZq9/fPtcJ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_09,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030095
X-Proofpoint-GUID: booMuW8w61ylkxDVL69AfNYN43G9bFEI
X-Proofpoint-ORIG-GUID: booMuW8w61ylkxDVL69AfNYN43G9bFEI



On 5/3/24 19:50, David Sterba wrote:
> On Fri, May 03, 2024 at 05:08:54PM +0800, Anand Jain wrote:
>> This preparatory patch adds an argument '%prealloc' to the function
>> __btrfs_record_file_extent(), to be used in the following patches.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/extent-tree-utils.c | 11 +++++++----
>>   common/extent-tree-utils.h |  2 +-
>>   convert/main.c             |  9 +++++----
>>   convert/source-fs.c        |  5 +++--
>>   convert/source-reiserfs.c  |  2 +-
>>   mkfs/rootdir.c             |  3 ++-
>>   6 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/common/extent-tree-utils.c b/common/extent-tree-utils.c
>> index 34c7e5095160..2ccac6b44cea 100644
>> --- a/common/extent-tree-utils.c
>> +++ b/common/extent-tree-utils.c
>> @@ -122,7 +122,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>>   				      struct btrfs_root *root, u64 objectid,
>>   				      struct btrfs_inode_item *inode,
>>   				      u64 file_pos, u64 disk_bytenr,
>> -				      u64 *ret_num_bytes)
>> +				      u64 *ret_num_bytes, bool prealloc)
>>   {
>>   	int ret;
>>   	struct btrfs_fs_info *info = root->fs_info;
>> @@ -229,7 +229,10 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
>>   	leaf = path->nodes[0];
>>   	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
>>   	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
>> -	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
>> +	if (prealloc)
>> +		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_PREALLOC);
>> +	else
>> +		btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
> 
> The bool parameter makes it less clear what it means in all the callers,
> as it is supposed to select the type of extent you could pass the
> BTRFS_FILE_ExTENT_ constant directly.


oh. ok. It can be done.

Thx, Anand

