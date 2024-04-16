Return-Path: <linux-btrfs+bounces-4295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793B8A68D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 12:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F388E28B2A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098112838A;
	Tue, 16 Apr 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IZs4pD7d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lnq9PYbr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E128376
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264160; cv=fail; b=haajVDDWcsFfIQ4M9RrvfUS6U/MHzVsT26pJaNS3Oiu7Rxac30k6AMkRHBrvBMri9ebOSPRzWuDoRp2bHxYgAWjCzofke4QlPwEDxEew2O6Syph7TfJi53a10CujDYWBMcGxntLYuZo+z7cCz2w6M6pIyhw/i0R61oGlTNfA0z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264160; c=relaxed/simple;
	bh=0fxhaTlN5oUcCpCAh7OXpvtytAZUDA4FLPzLA4sk4hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=khZaCmzf37IlKSCMlmi4IGhrJbQa+gYX3NF5joeauLLHpBNtX7dKfJjK9hIC7irjDrsjJai1UBMKiFkAVKkNuLvCs0zu1SsumYFw8YUclnpD2A2pTmSKT+C4+/HLqmeCZFEdhpceSlEXd2UajhOCA30vtSMr+nQXqvJJfGHn+20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IZs4pD7d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lnq9PYbr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8o8xU028298;
	Tue, 16 Apr 2024 10:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8DZ1nuuV6av6BZBRV74AzObRrFvAj8JC1j0GPxpAtow=;
 b=IZs4pD7dOlJsFSTnOhGdJCSSKsM1lco6a2P/6oV1s21m6WBN8bm5YC6ezsaFA5k1ZHSi
 etu4/HeLgsej6wTVjr8EPyg7gSZoyws+HdsG9wwdYCunNX3xsYxURm6jrrN7M7yBUPBV
 hrpuCzMsA34r0cuWdTqjlr7rcmxS6lPn70nl5kMnF9tlPks4E3V4YrrOsljqHaIDzG95
 +mZ/VPUjBNZ4b0IgARxII/DoIC9j64Jpyn7v2hvbmXr2DTNCE7UkU3ywpYJeCbtqERaW
 a8/K0WT99IN1JhhTgXzeQONA5zWEsDzyWbsNW+21AgPZ75kyWywU4LgBqvx2SJNYXmqC Ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycmxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:42:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GAZ5ZB014292;
	Tue, 16 Apr 2024 10:42:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggd9tet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 10:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFmQfla9C5JubHRw2UJIdZ7xQsK5G1JvnQv9/+1SMMOklzLvvFP34VVmCu7LdJeNU1jGZCzARGQ0OCDx1w9R4IxLkl+YlsMw79sxy7fJgsXuaNRCBfxBatZ4MmyzeJ+5Pgbv0q1zAff2ndRWtTV5aWW0SuLUH9aHPXbFNpz+6JeWeA0Z9rD93qNVl52J9RYHf+1sBB/LwTHWOr7WAswTxfC5Nns8i3QU8XGFv5bbTuilmpjWw448p0Csew1ggBKbJalHsAyVBvRO9wCxmadQcdLx6sNSPsmrryDL83wlEbkTBXItmaHRGrpIH7TClQ/kFKwz0Py0t2sZI/aFaXkz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DZ1nuuV6av6BZBRV74AzObRrFvAj8JC1j0GPxpAtow=;
 b=H0L2+yltvVRsRlpBLWv3A0Zwf70THqZMdlTipkG6d99+bDVTd80IjbtuVJKsneJSw0Z/9wD7/1RjPLl63+qaPWw/vdLrG03Y0ahMTzJUNwBGbR2JoA3i3/hvqx286fUbGhP5t1vXiIyzQXjz3F13Zak3M0vJ8DVTW7rvHXqDLWWsjwwGL2pNbvMk59kPHq+bQqlIryFlMHVUL3biuZL0SJcHzTO31CKJcOnuBh0Wlmn+hyX62jxmtuwWaKX46vhrKUWvELs4GP2nlEqIwCci74yy9ZJt3dudYYpAn5rgNdU0NawbE4/jLxvK8bumCYigFsVhk8guY9L5qd8QgP42Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DZ1nuuV6av6BZBRV74AzObRrFvAj8JC1j0GPxpAtow=;
 b=Lnq9PYbrJubZHD+Y5cFBxYBT7fTZgkmdWWzvENrPa7mdxQelAJYtDr35boUEFJ2o4f6jPo0jklaYZFcctMJZUrD6dFcGmZ5mWB9q4chYtMjbUizIa95ZMGLaieLLUDfEln87fUGObwda98b1BuItf5L4m2RRd8ixg/eusBfAFCE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7840.namprd10.prod.outlook.com (2603:10b6:510:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:42:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:42:33 +0000
Message-ID: <c124863b-9090-47e4-bd98-38a2e14e116d@oracle.com>
Date: Tue, 16 Apr 2024 18:42:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/29] btrfs: fixup_tree_root_location rename ret to ret2
 and err to ret
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b9fb4121b33c2b06ee0bcee74472c117481d2555.1710857863.git.anand.jain@oracle.com>
 <20240319182448.GM2982591@perftesting>
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
In-Reply-To: <20240319182448.GM2982591@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 82447e9a-8a41-4fcb-c4d5-08dc5e01ec5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Wl8PZ04f5Tox/szLaqBwQ4kk4WrwkKgp3b9FOzRere0fcCxVDC6yUWpqEaZjQardSQHNb1qv1eNKQJ/r3DxXzuCD4YBk65yqOCGnGT6Nni6Da38lgFswO9ZTiiaaM0PAChJ1b+9XSw1PnZwgTJ8s7rjMet1tX5BSI8FGgq7Wns4QaMzDmqgRv2r/lLrdll4Tjub27ihhCU9SQw0c6RTQWeNJVji9FCLFt0wPVSchAG91/xpNUMetjrzE/iIxvJinw3hull572RvAyrnEVGiunUF5tI5nX9kZqdG7w3M0a6J936nIDTAOQ2y08fEFvD007F7IeVVqLaqyDYfWLF+vjwO2UpJ+aXaZ3L3pX0PR5/37DekAnSr6oflKpmKzReS78TSkfq35k8wgXl3Z/A1fdcRBmVP5RXcte2N8Iwx/j1klv9bZcGse6tNNNjRkP3ReRoI7XbDhhduL8/MF4QtuuTxSPqJbWaW5z+nb33SUZ1Hkyk+z/BeuGKj7qEsQOQPqq2SLjpSkbZNQpuKRR1Z1jIUZJGWNF1etjoY8EmZj4/Md6Roail1UoFPxnKpf4r06QxGjHOQguvKglZVevv1A7S82kWkwcU3O2xhz/Vd0D2CFVwpKrSNCSvZe36PFDAYi4cnfbtKdk9XlWf5XfNgv1Psl8C1jVyzW7sjY5zpHFI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODMxZDNiSTRlVEdhWkIzN3VFdmwyT0psU1ZZWHRqSmNFTm9RYzJ2M2Y2MGN5?=
 =?utf-8?B?c3VxekZvQUlJdWY1MUdKL0NLVHYwQnRRNjJtTWJGcXY5MThaUGpoZFNsMk92?=
 =?utf-8?B?cHVKa1JTSTB6bGd4UFlmM0RqR2xISGhzNmRPQ1hXYmVZK1prNzV2NWs4Qys5?=
 =?utf-8?B?bzJRZnlPNUdVTThBMmNjNXl4cUlnd2RHRWhQSDYyK1lOZmxEd3V6UDJuNmhn?=
 =?utf-8?B?YXg4ODFvMmR5eVFmeVFKa1ZHTGlPOSttSEFpL2hid0xXZ2hPNUpzeXo1WW5E?=
 =?utf-8?B?alZNSStxWEMwb2NtTlo2VUEzN251dnQxaFNQaE9JY0IxaTRaMlo4d1hNb05s?=
 =?utf-8?B?NHhtR2RtenIzTjZteTNZYWpXVFN6SnRrenlzdk5Ma3M4U0xHSzhUVWRiWWlw?=
 =?utf-8?B?aHJXM2I5RXVKZVRBbEYyaUFIcHNRWkp0S1E3MVc3b0RNdU5iWXFkSUEzQTVH?=
 =?utf-8?B?cEo3QUlHenc3UmJjZ2JHcWdwU2w1cjBmTEpXdWRnRUNWRVJTa1kzc2ZsQzRE?=
 =?utf-8?B?SndMeWx5VmxzbE15RTg1cTJEc0g3M0xZcHhJc2NJcncyUlFoaHpSdHEzL0NY?=
 =?utf-8?B?c21vaXdmZVdFRmplLy9UaTJMb2p3ZlRtYnFWdFMyWG9CeWhsVjVsL0hKeFhQ?=
 =?utf-8?B?cjFURHZRZUVoZjd5eityOWdwaGg3dzN1VUFnblM1dHZuYjdhUEJVdWJFWHVN?=
 =?utf-8?B?U1VrOXA2Y1ZYM2tMN1ZnS3h3ZDR1VUZzdlBlVjRDdzNiQ2xSRlFUdHlCMjBW?=
 =?utf-8?B?Wk9RTDU5czRISStzZmkzK3JwejlFbWJYNmIyODhSTU9OWjNjUFIrWHNuTiti?=
 =?utf-8?B?ZFVsdU5XMlhVbDNQRzF2OEF0WDN6akRFZFNRMENITTY2TzBCWmxYaGdGamxH?=
 =?utf-8?B?MytkNHBIOElSQ3NPamRMRHpVMzFIdEsvWU5DMmVZN2NGdnRnNUJvMWJtbFBz?=
 =?utf-8?B?Zlg3dFo3UG9aQ3AvRnVoYW5RcTNtRVNiMzEvbnBPclFvMStScjVETW1yY1JZ?=
 =?utf-8?B?dEJBcndtU2hEUXduUUFwbkdUMDJIUTAzYjhuZnIxVEpZTmZaQmFYZElNMFhI?=
 =?utf-8?B?NlY0eHhwTUJwd3RsYktwcVc5Y1FqRG92enpLdnlZenc3c0s4cmdlNFBENEg2?=
 =?utf-8?B?cmZET3RlZ2JRWFltc0NXZ3hsVWZzRnNNOVlzbGZ2eEVaU2EzRjIvTkRyUVdU?=
 =?utf-8?B?MHZsRGRYQ1FHV1FWbytjQjJ1M3dQTlJRVndwR1pIWlMwdHdJdjJkeHY5QWJr?=
 =?utf-8?B?eVV6ZVZ3WXA2b2pnYjVtdmw3L05haTBSYzk4UDFFckhqWFZiaGQ5TkVJUjlG?=
 =?utf-8?B?V0k5b2s5Z05GMzNUTlJlaU01ZnhmU0tjZERVQmF5WTJrUTdCM2k4dGpSaG03?=
 =?utf-8?B?MTBabWZBMTJ2cld4U1EzeEY4a29nQW9DclBpNWdQQTVoNVpaZUU5OXJMYmNW?=
 =?utf-8?B?djlyNXU3RERyZVhUQTZ0MHBROVBNVUpsYkZieFpPTHdrRnAzTDlNdWZMWTVY?=
 =?utf-8?B?VWRRSWdXbTlXa2xla1BMaDJlb2h6dEhMOGNnYUU1K0k5czFpOXBlTGF1bStX?=
 =?utf-8?B?Sk5PSncra0xxWmhPd3MwenpoQko0YjNLcGM0R0RZS2JzUi84ZzdtREhMaHVJ?=
 =?utf-8?B?QngxK2t1OFlmUWdJMUNtaEZYdEhHTGhaSnloSjk0STdLU040eHViYmppd1dL?=
 =?utf-8?B?WTdXOUd3Zy8ySklZbVR5UUt6b1ZRWmVETDlZZjV0TEhTSjI4eG9GZDlGVHNh?=
 =?utf-8?B?TzFZdHllUWlOblQxN0VaUlNkNy8zT1d4b1dobDNGenR2NHR4U2p3UG9kZU1h?=
 =?utf-8?B?RHF2NGRZQ0dzQlQzZGR0KytsUHFqSkNtWmFNZ0c0TExoSE1rSXhYQ0xuWnNq?=
 =?utf-8?B?NGhSaWd5UytqZlJKL2s2WUdHNkdwbmZsamhjSU1yS2w4ME44dTdySkxFV2x0?=
 =?utf-8?B?d0VPSy8xY0NVRzdKQ29EeEw0RUJLeEhjSVY4NUhMMEhGamxBZHoyWHkxeHJh?=
 =?utf-8?B?UFZvbEhOMnNJUkVlVUM4NFFMOU54TytWbWRGWXdEVHk3bHRQNTRZSHl5U003?=
 =?utf-8?B?WVdBcVdsTHBKc1NTcUpNQ1RDUDRuTkZDZGlCczRTYkJDVm5HTUJKd1BNTllB?=
 =?utf-8?Q?hMVOtdtFgbSHDmyIIM3y9eiRR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JTFWZ1qUH5H5cIj4KiJEkfQRWdXeGuMRUWyV7m0fCQonjT+zWN530eNlesR7hd8WbcCRi+ae8iu7eKKqOx4KuZxZXx1JnaAQTxgVtY6kbZNpLJjHqSxKTIc04GfRoCq1trnggCLdlNAbqbpBjzswra+Vn1SOIehbxM83jVoecq+9yEZT0tnpD8kkLX+s/q9YbhVT+A5P00b1t3AwUyqUAepw9HYFTVbIkgudsqv3QT7FQ/U+qk8ezfWKM9W1exkOeWIhuEwn90rzcrtogGz3oMtSuOM13IqbeSrc4EyFavmrTPu/9Voq0t99G8XgJx2i4IzxjuaGfry6Pe5cx14MbYcmF2wMW5aFNuadAWW4X2JOpDH3O0L8O2jSLxpieBEErkNNwMkmmtvE5hje2wNg2LM2iNHj9KihhaRJ5O/SIJXDdDPAxoeEEUbmD4OtHcf/YJaYW21mAE9U9Hi3bFWBj/X0Se8pHsELCsOKyIv+P+VPMxbwnkckuw9lggF/moe9QfNhB/82i6pSBuge8pxRLwFZcYBIsmThj64LV4kYeMjShWEk2IQ7dV1nFaGeFBwixBV4ZaJgghgB8d1baOb9cRG8ggXj0XohRQ3gGqa2XpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82447e9a-8a41-4fcb-c4d5-08dc5e01ec5c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:42:33.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzscH1tawTZjVCKg5rE20U8LaTIbZawrsLncdeCoAZTzDqihrT3Wv2y1vC+8vM2Kf6rhCK3k4ysSxmiotxa5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160065
X-Proofpoint-ORIG-GUID: M7S315PVR4DqHhW0w9qh8NK0bPGSyy1y
X-Proofpoint-GUID: M7S315PVR4DqHhW0w9qh8NK0bPGSyy1y

On 3/20/24 02:24, Josef Bacik wrote:
> On Tue, Mar 19, 2024 at 08:25:37PM +0530, Anand Jain wrote:
>> Fix the code style for the return variable. First, rename ret to ret2,
>> compile it, and then rename err to ret. This helps confirm that there are
>> no instances of the old ret not renamed to ret2.
>>
>> Also, there is an opportunity to drop the initialization of ret to 0,
>> with the first use of ret2 replaced with ret. However, due to the confusing
>> git-diff, I refrain from doing that as of now.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/inode.c | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 952c92e6dfcf..d890cb5ab548 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -5443,29 +5443,29 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
>>   	struct btrfs_root_ref *ref;
>>   	struct extent_buffer *leaf;
>>   	struct btrfs_key key;
>> -	int ret;
>> -	int err = 0;
>> +	int ret2;
>> +	int ret = 0;
>>   	struct fscrypt_name fname;
>>   
>> -	ret = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
>> -	if (ret)
>> -		return ret;
>> +	ret2 = fscrypt_setup_filename(&dir->vfs_inode, &dentry->d_name, 0, &fname);
>> +	if (ret2)
>> +		return ret2;
>>   
>>   	path = btrfs_alloc_path();
>>   	if (!path) {
>> -		err = -ENOMEM;
>> +		ret = -ENOMEM;
>>   		goto out;
>>   	}
>>   
>> -	err = -ENOENT;
>> +	ret = -ENOENT;
>>   	key.objectid = dir->root->root_key.objectid;
>>   	key.type = BTRFS_ROOT_REF_KEY;
>>   	key.offset = location->objectid;
>>   
>> -	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
>> -	if (ret) {
>> -		if (ret < 0)
>> -			err = ret;
>> +	ret2 = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
>> +	if (ret2) {
>> +		if (ret2 < 0)
>> +			ret = ret2;
>>   		goto out;
>>   	}
>>   
> 
> This is another place where we can simply remove the ret2, just do
> 
> ret = btrfs_search_slot();
> if (ret) {
> 	if (ret > 0)
> 		ret = 0;

Original code returned -ENOENT if btrfs_search_slot() return is > 0.
I will retain it (instead of 0 as you suggested), I think it is correct.

Thanks, Anand

> 	goto out;
> }
> 
>> @@ -5475,16 +5475,16 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
>>   	    btrfs_root_ref_name_len(leaf, ref) != fname.disk_name.len)
>>   		goto out;
>>   
>> -	ret = memcmp_extent_buffer(leaf, fname.disk_name.name,
>> +	ret2 = memcmp_extent_buffer(leaf, fname.disk_name.name,
>>   				   (unsigned long)(ref + 1), fname.disk_name.len);
>> -	if (ret)
>> +	if (ret2)
>>   		goto out;
> 
> And here simply do
> 
> if (ret) {
> 	ret = 0;
> 	goto out;
> }
> 
> Thanks,
> 
> Josef


