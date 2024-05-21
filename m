Return-Path: <linux-btrfs+bounces-5170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE68CB29B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DED3B21F53
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85377147C79;
	Tue, 21 May 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NUztmXx+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NQeeaTma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58122F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311429; cv=fail; b=qZxhDM5eF64YDnLwK9tAAjPHiRPcenpglTf4HDv5pChKpyK7Cg+aHkR/6bWM7Hf4mBPfqL8yLOdVspVJh1BlLA56L9iTRXnL4z02Bf9W2PxBTbLWsD6W8x9SzvGO4bbtts1Y7Kc+n+zcz3TUUOoSpwoCuwu9HABy/UN24SZdtp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311429; c=relaxed/simple;
	bh=3OwDiljf6CeQHUrOzyORZaRKADG9A+L1nezVlEQKZPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kF8giH/tjnhicLb2yJx8Wf3/XMcN/5AT57AA0Bc3VZyyxJxciSnz3qdFcYFD3vDtHzK978yScggGDeVaXaeQNPfLf3YjqNNmtaD/mHH5hOsepH8jUxWZ1ZQVSIbjqg+9RirkoSnMr8ybjkYagcXTGxiqOGGp9GpalJOKt5nSBRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NUztmXx+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NQeeaTma; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGx1sX005611;
	Tue, 21 May 2024 17:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2atlFTbaDWg44/DGclyapwIipNbyVCIkMYLFJ7YpbSs=;
 b=NUztmXx+k9bOiDk26d7PBBrY+eJafFQse43lLUhkmb8Hmyp5BIscguHZfIRM7bsTtPyj
 4CQtqP0DC7VQxU6zIQgjoONzPle+S6wK0bgjqKpzchHxlyGh3j7KqEegZFwMDddnVutZ
 lZrrP7HBKehybzq7euZKWErB+X35s8uP2Q7jksvmvcxNl1ZmI/lLVYBPqTEqACTMAWqy
 rod/s2gu6sNglWEs/fxvAMhz8qb2mcucoGuwC7bIjziaTrb5tKZcBF7Yw96TEoQEEQS7
 MrBefmnNYFoQhf5maiG4vftXVCoAlLbW0SCauskeAIPMJqqJ3QUr7d8CMoXvTgSMHfUg HQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv5y5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:10:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGkHxI004930;
	Tue, 21 May 2024 17:10:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88p01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2gP6IZNUOxvsS7zWhvHoWDG7IU3fmcL+r8dPc6kgCaFf3tzxcMNsVb+vVz/gmwy9tEr3fX+iH4fMEEum7+/IAtFzcWDFPnh5U/wN8xYi58zkpIKX+dYbqeq2fy381ZY6UNTXL6ekMNVzC4BhRvCN3z0/bRFxCQx0zIE81TQbmsCEhxAFnx3R/nVEt6ifXwQ3k6B13AQnNwT/AVfmIoKPWF/QY/cfSRZ64zSYuxdeKZ2UvQgV8MMgfzBTgFuCL+Il4x5YVNcSbTTpp58J5dI3LoHy3zlRm5eiF+MO2CRBpkqNHs7VnnHHknjmKHkpK7sfH0KDLEUCs6xNcjRVD4mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2atlFTbaDWg44/DGclyapwIipNbyVCIkMYLFJ7YpbSs=;
 b=GO1+iaNXTQ5ybmFKZAIu0yYjSLgMny6fCNxyQA7XXZiQypz/bSgiExHfjSVY5EFHN8AbfqmEGdIWuVJvpZjYQdLEGQMa0Dtw/EmD1WRo56CfMqxwRK1rXI/UuiDkiQd6KSRUdCPu5txpbj0qLL04YxxzsK+KJumgHuss7sduZosc4u+os782IINwtK+YW9XR0OOu8rCrt6vaJIyjv51QSZw/p42Z1QtwRdJxAF7RuYCHNlcsb8Qz3pHawstyqqyEFbQS11MhaBkVHtiQ9XMs9KwgNajnCOp3p2GAmQIS3z41evf9jp33kRcAKdGAmee9e4EwWEHaA3yTqd7Q9kcr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2atlFTbaDWg44/DGclyapwIipNbyVCIkMYLFJ7YpbSs=;
 b=NQeeaTmarUxLjpvQzesSmKQa/uqH89irj/tVllcTM5AoDu+LuFT8A24mwwBjO97N7PBO3xR+YtoCd15yJCcgR9qYxcersgauC69afn1/kWlLsIVlD48g+zGl6WSdniNWlPPrq7MmxE7ZfPRqJ4mdhKfBOg/HlXWBjp2ajTKsLos=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:10:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:10:19 +0000
Message-ID: <3c9cdd87-87ce-444e-a576-7e9626df04ca@oracle.com>
Date: Wed, 22 May 2024 01:10:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] btrfs: rename and optimize return variable in
 btrfs_find_orphan_roots
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715783315.git.anand.jain@oracle.com>
 <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
 <20240521151820.GP17126@twin.jikos.cz>
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
In-Reply-To: <20240521151820.GP17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4defe78f-6f89-4659-f954-08dc79b8e41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vjhwbk1pT240WTQ2TjNQYm4yRVVNZE9sN0RldGZyODRmMTY1U1BoendHQWNv?=
 =?utf-8?B?ZHJ0d1lLRUwxSENmejczajh5MVJsbys1VHFBOVlTbHQwSExXSDdEcE5udWpm?=
 =?utf-8?B?elhoL1VXUVVnKzVRc0M4S0Z0Rm9laGMvbEpMZXBVVlBBQ2I4L3IweGg0dW02?=
 =?utf-8?B?TnBBYnVVaHpodjRCNjFWd1ZRblovZVdObWRNay94K0lPYW5HWm1TdFl1cjZ3?=
 =?utf-8?B?emxSclNjZC90aCtnNHJiejVpbHRTSFZXZkVHeER0WVkzMGFJbE1uRVV1ZFMy?=
 =?utf-8?B?cWdkOWdhRHNRYWF6L2RvYk5YSWprUFZWc1F4Zk52NTdIVTl3UFUyL2MrYjVz?=
 =?utf-8?B?RXJlSFUwM1J6eVhPTG1OR3Fabml3TFBYcGl2WEJ1Uk04blpra3ExVitDdE9r?=
 =?utf-8?B?dFQ5MXNJSXJJNFFqL2VCYWRoNkdKSFBOc3NONVNUSjdIYlpYWDMyVXlHbkpq?=
 =?utf-8?B?WUNaUk1KbEtDV21xWmtuaXJaYlVDYm1YRDUxN3hkR3dRYUZ4S0Jnc2JuZkl1?=
 =?utf-8?B?aXdLZTZybUgrSEd5VHVIWDVpSGJwMkNOQ3NxTHJUR2dpM0VBeEJGMlJ6c1NE?=
 =?utf-8?B?T3dFWEVGWmtrTzVzYjNQUW5hN0pHODY0SkxsK2ZBMFZmNTdvcTgvOCtQbHMy?=
 =?utf-8?B?QXFKN2R4NGhsMzExTXZJQWxJeUpKdi8xNGU1dnM3a2tiOXlCaUhFS0dMU0N6?=
 =?utf-8?B?eW50U0JOM0NFeDdhYm5tUjZyZGtMS2lBVXNjcThOQ3JqNkg4YUpiNU0zeCtq?=
 =?utf-8?B?TWNjbUVGYzJoR2xOMjliVkNMOC9oY1BHNlpoSFZzN0VTdmZoSDNwanVVS0Y1?=
 =?utf-8?B?SWM0L3Z5a1ZGM1I0dG5KZkNGN2dkREYyUGhwMXdWTU5vd2RhajFnYWhBYmN0?=
 =?utf-8?B?QnNXZTduY0V5Nm14cVcrQ20xdGkyUjVPYUMwbzlwZHNyQnVXdXNwcXo3dmkx?=
 =?utf-8?B?VWxrMlQ5ZlhwUDdTU1pOWHd5WEtWZTJGcG44Y2hCODBjSGxwb3E4WWdJd0dN?=
 =?utf-8?B?QnpYUVhQKzNOYUs3cGFmaDAxaDNLV0gwejBwdHVBd3hrcWpqeUVwTmFnMGlY?=
 =?utf-8?B?bExtTnZlaUVhSlFrR3gzYXJabGNxUmk4YlNRTW5yUkU2UFYxRFc4RnhXRVM0?=
 =?utf-8?B?a2NtZGhJR2FsOEZEbDMrQTRUTDRzSlQ0dE1TQU1COCsxRDhTaFRFMGhxenY4?=
 =?utf-8?B?S3ZwQ3VlRUJWcHprQ29KVHZnRHQzMHU3QUM1dU9lRGU3OVVWVlJieVBic3p4?=
 =?utf-8?B?dHVkRTRGcDZYSmtKOENOM3VaMkhSL0JKR1B5eUNyWGgyQ0cyQW5ldCtpc1BW?=
 =?utf-8?B?eloxUlE2UVlxQ3lsT2Z1SE5qRjJ3SXY1ZEVwM3dFeTJDNENtM0JOd1B4bzZE?=
 =?utf-8?B?Y1FiSjJjSkxZZzcvVm42Mno2UGxrYlkxbmpoMEt6QjNITmVTTm1HT1QrV2xn?=
 =?utf-8?B?WmM0YlFUQWp0R3pUSlV1ajhRM1d3a1plZnozOGMwZ3JuOUJpdEZwNS9nS09E?=
 =?utf-8?B?bG51S0krdUthSk9kNU9zTnZISGZsRFM1VHZERkxhUDQydnBDMlB0dUhmT2FS?=
 =?utf-8?B?d3RwODJISWs5VCtnWGZObTdRU1lpUnlNTTNjdmpFak9yUTVjNzA2MGxpakNy?=
 =?utf-8?B?THBNeXNISmVCMmJ2Q0Q3NUhQamozdUN3U0x3QnVIb09DdEtuRzFTRVNPazl4?=
 =?utf-8?B?VFl6UFBiVEdmOHJjeHN5bXNMQTFpa3cvckZ4Y1pwckJteDR4ZmdFMW5BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VS9Sd2R0QTA5YUFtaEU3c1FmMWlNRmIwUUpOUEVBN3VGOXBUNjVqSm9vZ2pF?=
 =?utf-8?B?b3o5RnQzUG5iTVJzZlNZRVkvbVIxcG04aDRTVHJjREN0akZld3NwUEw3YVFi?=
 =?utf-8?B?aWVuQ1NRdlRod0NEUkw0T1JpeHNxSzRUc0d6L1lmTTMrcnRDb0pUVFJTZHpj?=
 =?utf-8?B?Z0RoZFhNVE9KRGkrd1g2ZitlNUNKc2JkRDJKWHA4czZPL1ZJOTVFWkVQdVZj?=
 =?utf-8?B?WXJBRDlCYlNoVTZqQS9DMlJJVkw1R0xOajlkV252SHk0N3BhaG8yMm1wS1Jt?=
 =?utf-8?B?Ris2cEhhQlM3Tm5VRmprcEZ5azk4Mmw4ckVKeStCeTBKQnJzNlAvcjNpNHMv?=
 =?utf-8?B?cDM4LzdjbmVlQVIxcUFiUEF1WFgrQ0NLNjhBOGRrUURMQ2tnZXRJdTdCMk15?=
 =?utf-8?B?Mi9ncDBWd3c0cGhkWnNQTlgzYS93amdwbXR6MWF2dHVrb0UwV2ZoaG9hbVBt?=
 =?utf-8?B?TTBaZkJBRTBuYTlQLyt6T3dnSXR5cFV6Y05VZEduM2NkZDZ5RS9GWWtkMTVE?=
 =?utf-8?B?bkUxVVJHTVMrc1JXdWkyNWxuMEVFaUVvdit3KzkwaWR6ZTJqK2hSREhPQ01Y?=
 =?utf-8?B?U2dxRU1yUkREY1Bnc3BpUXRmYW9iNllwZGFweGZNdXljUHk0eG9XQW0ycHZV?=
 =?utf-8?B?c09RdHgvZnRwWC9nRk9INUhXbW96dWVjWlYvZzNWVVNNMFN2MGlnWW1OWkdP?=
 =?utf-8?B?QnJaN3h2eVdTUjR2VU50c3FSQ1FoQml6d25XZnFDVDVhSFdGaDFWRmFZWllO?=
 =?utf-8?B?NmxJdjlwTHJkd1RCMnFrZUdBcURrSW9ZRU9CUjk0MmxKSyt1N0V1VUJtbUVv?=
 =?utf-8?B?VFVmNURBWnQ0YzlqNVFSZGxoTUtYeTZyY0tHMUFJU3E2Umk5c1o5NnlCbE05?=
 =?utf-8?B?RzZPL3BFRms5cThETEhTUUIzbEdIbHhuTE5FRTd6SzdEb3U3d2t2aXo4d2lw?=
 =?utf-8?B?Zml5RkpGRGt2SzFod1BGU3kyZWI1TlZXYWZ3a3JLWGlHSXBhVG9kbTRkeHZP?=
 =?utf-8?B?dDIrVUVBa0tZckp0Z3JDRGNxSERpSzFiWXhMT0l1VGFMOFJPSi9OZGFhNWNI?=
 =?utf-8?B?aUpTTTdsYjFscmtWMG9na1ZKN0s4cVN1ZnJkOWlJdHZ0ZWNlTXp4eVJ1VFdO?=
 =?utf-8?B?QTFWTyszdjJoTVpaSnZpcGRGRmtINkhxQ21GWHVLclBqck9IeXF4eHJaUU5R?=
 =?utf-8?B?MEIxbW9zYTlJYnpLdzFzTGYrenJIRGUrUXJyNld0YmxUc2dtWVplUWgwbW8x?=
 =?utf-8?B?TU5HMTJ2MzQ4Qlc1ck0wSDlQeXN4NzJ3emVrNkJWa3Zwc2hyS2MxamlHUFhk?=
 =?utf-8?B?M3B5NEsyd1VhVW1ia2dDeThTa1k2dUtPS0NzYm00ZU5OTzlaanBScnA3KzNI?=
 =?utf-8?B?WUpxVmwvSVh2Z3RZbElyUk5PZTJIV3pBdXFXdVRZbk9OU01LakpzMTh1Sk81?=
 =?utf-8?B?SzV2VzR5eUwrK2V0cjZNamFtTmZ0QjNxTG95WjJ0cVZIRDlGUnpSbVRPcmtu?=
 =?utf-8?B?Mm04RmdLVHBMUGdyV2xrRXh1ZlNmTGkyZ1pZaE1idGpHVW9icW5JN3ZhWmY5?=
 =?utf-8?B?TzlnWlBZeFY0aDQyU0s1UzBIRjlWamhSRGtCajV6MktCMXJLdmFLT0dPY0lC?=
 =?utf-8?B?dTkyanlSSjNPd2I5ODQ0akxsQXNJU3hVOGdQSnU1VFQyN1ZQYWZ6ZUpDTk5D?=
 =?utf-8?B?UnZnV2tzSGRMN2JKSU1jRm5aSE11UDQ0SUNyWkVrZ2lXR1ZHaFNmUUdRRUxj?=
 =?utf-8?B?S0NMYkFsYlRVMlFoeUVpTlkvcU81NjJHK3Y1R1N1RjloajlXQW8yZzFhRnIx?=
 =?utf-8?B?bGt4MDdDOExnVGJXTU44aUJtcUViT1oxOTYzd1RHQjF3clpkRTdZUjVSUFlx?=
 =?utf-8?B?UGxuN0tWcmFlNVdJR0Npa05xMVAyL3llb0lRSUxGeHZjRFQwUGVxM1hOUHNp?=
 =?utf-8?B?ZVRRMW5lR3BJY0RuNE1TK3hZKzgyTmtMRWlOdUgweE10RVltL1MvY2lZL2hM?=
 =?utf-8?B?QU1zWUFzL2dEbTZGNW1XYm56NzVoUmx4bll5ZzZobU83azZGVm43SDlLTUZN?=
 =?utf-8?B?cThwVEtqMGc1ejVNN2pQalFXNkptRCtWSXVhREhacFQzK2ZTVy9jd21QWGhw?=
 =?utf-8?B?SitNTWxFa3lOTmJodlI0K00yOXJRTjRSZGxKOXpXaTUzdkV3eGZaWFhpRENJ?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C6FNTLHlbVQrZOOx9i0IFdiyBmb+INi8dTTVKEM2O/X1llvYdahc7Ob4hHKyUpH/WhvEyPZu0VZT7lbjpEUaiYKW2/rlZtmiyoA/LVDfKCkffsbz8/DQ8i2MRboGiWEouGHj8jAgYtOVYYTdmuA/q3YZXP7kh//Nz5AA1qERPpLhQAq0t0Mwa1nX56czJWDs6UmFCxbxyIA12kkKq66aY51b3IaBKyWkljkd0IXWb6BAUtCkUjelIpf47HH3t3YDiooh5d+kO/nXT59Injf+m4YZLgAFqQfOxElvTwGXwN0oCTy0GMKpXeQ1FJyifwqDLqOaHbJsMjHK0kH1+mwLoXyga/v3L8GzWmcsCC9yh4BK/3/IM39J5B/+kXOLOKJFnRCDmWuwV0v8lPNIW/yZz3M5ahODT9yIeL2H/3ZXw0i6E/hbTKV9dsICoF+DXfZ7Cs9gYrZw+uhlzPKNXY6ZIKTrdwBY7wGnylTpj2uMYXyUq0cyHIW3jENGjwA5Oihprc1UnHQPhQ4YfOqHVf3hFz0c6LqpM+pzVMWIe2/3WUYO335j5NNtG22WfI+OBEMLqEy68N+4HhpkOXz5jCnGnkJu2teIi20aNI0jFytezPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4defe78f-6f89-4659-f954-08dc79b8e41e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:10:19.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ+jvZDMY96m20lccEti81I12UGsrGchzLBvXm6Ki+FohnNBzGMV95DPSZtDXDPUCLmnpjQuHzvJifyvxRMuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-GUID: XAE8xjqzJz4R0S2zU5UVf_mP_9aWOn9e
X-Proofpoint-ORIG-GUID: XAE8xjqzJz4R0S2zU5UVf_mP_9aWOn9e



On 5/21/24 23:18, David Sterba wrote:
> On Thu, May 16, 2024 at 07:12:15PM +0800, Anand Jain wrote:
>> The variable err is the actual return value of this function, and the
>> variable ret is a helper variable for err, which actually is not
>> needed and can be handled just by err, which is renamed to ret.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v3: drop ret2 as there is no need for it.
>> v2: n/a
>>   fs/btrfs/root-tree.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
>> index 33962671a96c..c11b0bccf513 100644
>> --- a/fs/btrfs/root-tree.c
>> +++ b/fs/btrfs/root-tree.c
>> @@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>   	struct btrfs_path *path;
>>   	struct btrfs_key key;
>>   	struct btrfs_root *root;
>> -	int err = 0;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   	path = btrfs_alloc_path();
>>   	if (!path)
>> @@ -235,18 +234,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>   		u64 root_objectid;
>>   
>>   		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
>> -		if (ret < 0) {
>> -			err = ret;
>> +		if (ret < 0)
>>   			break;
>> -		}
>> +		ret = 0;
> 
> Should this be handled when ret > 0? This would be unexpected and
> probably means a corruption but simply overwriting the value does not
> seem right.
> 

Agreed.

+               if (ret > 0)
+                       ret = 0;

is much neater.

As in v4.

Thanks, Anand

>>   
>>   		leaf = path->nodes[0];
>>   		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
>>   			ret = btrfs_next_leaf(tree_root, path);
>>   			if (ret < 0)
>> -				err = ret;
>> -			if (ret != 0)
>>   				break;
>> +			if (ret > 0) {
>> +				ret = 0;
>> +				break;
>> +			}
>>   			leaf = path->nodes[0];
>>   		}
>>   
>> @@ -261,26 +261,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>   		key.offset++;
>>   
>>   		root = btrfs_get_fs_root(fs_info, root_objectid, false);
>> -		err = PTR_ERR_OR_ZERO(root);
>> -		if (err && err != -ENOENT) {
>> +		ret = PTR_ERR_OR_ZERO(root);
>> +		if (ret && ret != -ENOENT) {
>>   			break;
>> -		} else if (err == -ENOENT) {
>> +		} else if (ret == -ENOENT) {
>>   			struct btrfs_trans_handle *trans;
>>   
>>   			btrfs_release_path(path);
>>   
>>   			trans = btrfs_join_transaction(tree_root);
>>   			if (IS_ERR(trans)) {
>> -				err = PTR_ERR(trans);
>> -				btrfs_handle_fs_error(fs_info, err,
>> +				ret = PTR_ERR(trans);
>> +				btrfs_handle_fs_error(fs_info, ret,
>>   					    "Failed to start trans to delete orphan item");
>>   				break;
>>   			}
>> -			err = btrfs_del_orphan_item(trans, tree_root,
>> +			ret = btrfs_del_orphan_item(trans, tree_root,
>>   						    root_objectid);
>>   			btrfs_end_transaction(trans);
>> -			if (err) {
>> -				btrfs_handle_fs_error(fs_info, err,
>> +			if (ret) {
>> +				btrfs_handle_fs_error(fs_info, ret,
>>   					    "Failed to delete root orphan item");
>>   				break;
>>   			}
>> @@ -311,7 +311,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>>   	}
>>   
>>   	btrfs_free_path(path);
>> -	return err;
>> +	return ret;
>>   }
>>   
>>   /* drop the root item for 'key' from the tree root */
>> -- 
>> 2.38.1
>>

