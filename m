Return-Path: <linux-btrfs+bounces-5253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0F8CD77C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6AF282633
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E03A17999;
	Thu, 23 May 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQQ4ucUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FvOGN1hh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B214A8F;
	Thu, 23 May 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479004; cv=fail; b=IKXp3b8/QuwtSwSqvxhwRzqIPbqnXmlc2Kosdb2+tZZneT8r8FWW3QWupw3pOkZPvXW/e3sopxFK1OT8we+xfzNTOI34dc3xa+5XwNe1qOWPiyhDsdiOX36g29QmGYfEYd2nTJ4XY+q16Yq3RRfDFE8OUDwaPZoLF1IZFWdy794=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479004; c=relaxed/simple;
	bh=KqWmgYePqyvp3xAkBWKnbHqwnTHmY+GnLwxK2voaghM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQFVmXJTpYtrutncYOcYNSyiKWNwKrXkJyD4HRT01S8O82XgE3FywG8aHxjPjJoQ6TvZzuVzFT2KNG78jlVYxKChE2XYvH5VZ0tKkOFajAHU2V2hRQVh2S6nNgXHHgcpCXDB+OjbEfsRK8avTUKLNWsbbi9IXjBqHg9N5XVASD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQQ4ucUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FvOGN1hh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEi2s9021737;
	Thu, 23 May 2024 15:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yKyh2sPqRjdZzheim2Hfn2lLyBh7pZKozmUhQWdoDcE=;
 b=cQQ4ucULmVBLOcUIxFuQpP7sV1h/LUZJ38JOo1T4MhgAVywJ9vl78nzQBIeVL+PvXJqC
 rEtc7z4fju20imAqpOdTrtgZdU7CAvkMhn9T8HXp5Bnl2z99sLmkHFnH1PIGoXuta1/E
 Uw+7GV6b8gnGj1pwq16mage1RGBd6TrgRr+ylptpzvHs0jfAbMuWm8iL4Th8hXnl9xr3
 F9VoB/AAtg+hS/thsuAClDAKvk6yWeXYKJVmSvRVSA64JV2QjMuiVJ1ep/HAqElA8SjN
 9MLByJ40nGtXtgUY0RAeJx23g+8r8iyVIFJfLjwe+C9sdclwGL69DoxyjJwvWhZcQ/nh PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mce2kys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 15:43:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NFMdoH005048;
	Thu, 23 May 2024 15:43:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsb47ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 15:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM0Bj3843VcDBPwBgme/Zqy04C5v4HxHLXm/5VS4Mt5FkrwP2Cnza+BM8tzOI3t5srNRvrldBbsV4Cr1ITbROi0Sb2MR1tyGaBBKVwlsnRotpqPKAwO2IjeO5rWts+K+4aqs9rnRZK+snCoVHszGyxhzQDl9TXhZ3sEPZe8qpOuHkslq8Ms/fW/bkKzBeiaBM6mF1uiFwxTupwIMlXvj4A1IzYyNbRC2TsIJkKpdZGUwhgTVt5Kk8ED+FDi1X3CsqE5zXn459mBLTFIuYuUBsMJVmkYk0vgooT1RlgV09dDXMY8W7ejFeUSEqpOE2NhZG121pNrXTdXAWI+XKHA0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKyh2sPqRjdZzheim2Hfn2lLyBh7pZKozmUhQWdoDcE=;
 b=L6sARMw91W4R/x7rQZlafBSGe5ec9TZUK5wyKayqX3nIHq6eIs2KCOQQC/Lcr1d/gYMGyULCBWT11OwnnTdMduGKr2eZvWWOMk2SYRWSrOBDFmYAlKml1K7+Vg+T7Da8L1sT7Yc8rnC6YZ4emmm9TuCtqLhnjwWAiHi7zgwQfvblRE2PL8Xy2W/X6KZKqKWsbPUnPIJLM3Aqd3OODzr3AGBXbfub1Fipu0/uCMIoURrvpVN4+OIkMoR6CALVW42eTXV7Tn7GosF7et1FPqT4HXZmmn4oYFvC+Dyy8d0uGd+G8AZfbcUkTA3TJUtpbET1V8Tdh5eRr6DOeeFjKPE1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKyh2sPqRjdZzheim2Hfn2lLyBh7pZKozmUhQWdoDcE=;
 b=FvOGN1hh350qCvlZcabDhk66TEE5uH3OeFn/iBCmBlZV2wVtZZmNvJNXY4Cx/KtsLyoSyfJ4frN4XuUpUBVxDbi2Fj+kh9t0MCRXkj2q8P4J5SIVpHK9nLl3ilmL9yjMBIPLDAu5MLToy9yidSGHzVxqfVawq9qtZpEf2ssGjFg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6545.namprd10.prod.outlook.com (2603:10b6:806:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 15:43:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:43:17 +0000
Message-ID: <a186cc1f-5cea-46e0-8f83-bf0dde087ad1@oracle.com>
Date: Thu, 23 May 2024 23:43:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/301: handle auto-removed qgroups
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20240507070606.64126-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240507070606.64126-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e93c82b-0b23-4408-da55-08dc7b3f10b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3k3cFpBa2IvRm1oczZXMUNEaVVvR3ZOamsvVStGekpqV2RGNVFZdU9laWIv?=
 =?utf-8?B?dDQxc3ZYUkQ2TllUUHN1c3lWUE5wYmtSd1lXQ2RtNkdLOGFlSXQ2Z3RPeTNS?=
 =?utf-8?B?d2xCWFQyZWFQVFd0dXkvVnJZOU9QdGtTT1liMjdhWGFUSHdTaVl0MnJTU1ZO?=
 =?utf-8?B?VTMzZVQ4L04vdkZPc2hzQ1V5aWdzVmN3VjU0dHg2VnNjbUFXQlhEcjNrRnJh?=
 =?utf-8?B?aGdScmpBRHFwQzZKeWN3Y0J0VmVNaTBHNzFmdWF3dXMyUUhaSXZpaEJtWGpr?=
 =?utf-8?B?dXpLcU9xTGJLVmduVlptWXgvV1RldkJCcUVDeXFmaXJxcy9uZTB1WVZsdkx3?=
 =?utf-8?B?dTkrUERnWXdGZUpYVFlaNlZoTWVSZ3FhRWthbmdPSTNwS1B5UDZMUkF3K0E5?=
 =?utf-8?B?N0JQY1dBMmx3NXpwcllhSGFIVHUybFJ5TzdMaDRVRkQybVhqQzRpM2FXV05Y?=
 =?utf-8?B?VFF6bmx6anYzOUtqMjZ5VEtnQ1p4T09EN0tGVzMxUU45amlna2ZQdW5EenpY?=
 =?utf-8?B?OUN0ajNHbTRQTFY2OUY1MGl5dHJibHpvSm1IOERjMGpQbDRJcUdpRXhBai9v?=
 =?utf-8?B?ZEE2Q0dUY1ZreVppTXFvQi9ZQktkaFIyU0lPbzdJdjJxbnd3Q2laNGZQSUJj?=
 =?utf-8?B?NGZKNHJpQVVkaU03dUg1dklFT3F5Y25UVStrdkxhaTJ4STJ1ZXRTeE9sb1NR?=
 =?utf-8?B?MmkxQ0k1ZUplWS9PdUl2OHU4TUVDL3U0Zk1tYWdRSmRYcTJZdDByWGVKdnRR?=
 =?utf-8?B?amxFNm1FTGZnZUlZZm9iL1h3ZWd0Z0hzbENOYkhQcVc1WWE0MGdMa3FCUW5Y?=
 =?utf-8?B?RUZNU0RrdjFFRmJHREZ3QUhJVUR6MFJaaDR3YUM2OEZhRWRYcThwWVpFdmox?=
 =?utf-8?B?NHhnbzNOeFV2L3Z4K0g5U3ppOHFJYTF4NGFQZEdJaEY4TWdKWmYwNk92MHo4?=
 =?utf-8?B?UE9ZaFBEMnhyVjV2ZXdUZUFybTYrK2IwQ1lQSFMxK01nMFFjRFgxOFdqWEV1?=
 =?utf-8?B?aVRBK2d2QktIZDBsZ1hidnhKb2tXeStIYWFVS2tRbkJ5NTNQMzAzMmR1cWhr?=
 =?utf-8?B?UUwzR2tnMC95TFJFYXNIejBQK1hJRTRSa0lxUlZXWURGbnRDYWFmQ01GcW1J?=
 =?utf-8?B?SWFjaG9wbVI5clVqV2RSNHZhaDhnRUNMc3l5RWhrWXdiNjNSY0Q4OE90SzBW?=
 =?utf-8?B?RHhRSUVBK1dSbm1qdjFQMkVWT1c3RUM1SEEvTm80cGVyQkplS0grSXFrQXFl?=
 =?utf-8?B?a0lmbVJhYnpNOGtLREszbDNYN2JmdC95dkcxMjV3aC9FaDR1MXZ5UzZQVnVj?=
 =?utf-8?B?dWU2ZUUxVDJZclNWNEM4cTg0SldWRFhiNzVPb3llTG1XeU1TcjNvVVk4UVU5?=
 =?utf-8?B?NTNsUzN0cDdBb2kvU08va0JqV3R4Tlc0RjJKS0QrRzVqSU8yNHo5WjFCenRx?=
 =?utf-8?B?SVJzQnpDZGMvZ0ZTK0YyQ0FjUDljbUFSR0ZaZEl4N0ZVdkxqL1FNT0FERmRq?=
 =?utf-8?B?YnBteTVUcktmaURqeURpVmRTUTVmUjRna0tOTUQ2UW5EVkV3M1pFdTY5eDVE?=
 =?utf-8?B?QkRqQVpLS1FQY0hEeGR3Q3d6RW0rNUF4aVpDQTFDS2Z0Tk8rN1d6Mm9jL3pQ?=
 =?utf-8?B?WXlmMjBNN3k4dE4vZWRTcFZ2M2ZZcHl6WlE2L0RNYWMxczZvK0g0dU12SFZL?=
 =?utf-8?B?MGRKMTNEcGwvSW4vL1VCSWV6cXp1VUpTWU5ZbEpadVNqcUtDOThucjRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1BSSzZqNG9aWnAvYVNnNTB3Mm1mNEowVWpNUHFHNDdKdUdSaC8xVDJJb2Yy?=
 =?utf-8?B?K0p2WkpxeStMWjRMY202Q0ZOODBxMXBFMHdTZG0yT0o3aGJmRGZaU0pGU1BK?=
 =?utf-8?B?UEwwM0E0dXIyK3hmZDB3MllTZ2ZoUGxBZ1lTTFFpaklXVkthNy85SzIyVjBu?=
 =?utf-8?B?NWtFTENBQ1VKcjgwcXFCaEdLWEpSRjdINTBscmxUNjA1eGJkenpDUktGRDV6?=
 =?utf-8?B?Y0ExNzhFek1INkRMVnNpcEZQT3lQRFRuWlNWZjQxTnMwdFB2dDZtdHJMSUtM?=
 =?utf-8?B?bkloc0xsejF0ZWlvOWJmeFdLM1UrUko1VHh1aXhnN212TndTclVYNWh1dnNS?=
 =?utf-8?B?ekZuKzdrdHZNeVV1Q05jeC9pbFFZVzZWd3Q4YWZOTkRqWjZnWG1kYTBCaFFH?=
 =?utf-8?B?WUhwMzR2UkRzL0JjZzZ0RVd0b0pWYmRsc1hDekFFcTlMdHgzV01uVTgxaUZP?=
 =?utf-8?B?T3FEQmhvOFFMUjUwc0Q2RXdrTk1vejFmQll3Yk1IdTNwMC9MRzM0MzdpWFlK?=
 =?utf-8?B?eHhnVnp3MkpXeGNxazk3Yjc0OERKeWx6SWVpZ3RIc0JwQXVYZ01rd2VMMWcy?=
 =?utf-8?B?V3p6K2Vxbng5czJObUEwdWhWRzRDYWVpMll4L01KWEpXNjRNK1V3STFaVnVw?=
 =?utf-8?B?Tm1GZFRFdlpML2paTWFvdmhzY3FyNTViYkJpTnhjdEd6VDI3YlRtZEVEcWVi?=
 =?utf-8?B?VzJSb3R5cnIvYlRya1ZFWk8ydmdsc3JwTGVYR3RNSFg2UXdheXZzTGFraDdx?=
 =?utf-8?B?bjBSNWpNaHlpUWJrbzBFT3VhazJVZ0FCZldTU1FYTG5tN0FOR215SDJ2dWcv?=
 =?utf-8?B?TEtxLzRralZVaWdseTJhR29YRkpkWFh3M3BJelB5UjZDS25LQWFVUDIwM2lq?=
 =?utf-8?B?R3hXRXNiMEpaSGZ0ems5amJGb1pWa3NHMWlmY3h2UDJsYlc4dW5PR3JLYUNO?=
 =?utf-8?B?VFRHQ2p3bHp3RHJhNVAzNWNHYjY0L29UTFBGNDNGWnFBZVdmTWdTem9wRktJ?=
 =?utf-8?B?dVBqVGhVUSt4c0tqWTg2ek9NTzJZNE9USm9IN1diTENtYmN3UU42Q2tEQzRO?=
 =?utf-8?B?bmtoYndXd3ZmdVJlQkNNWUlCSlR3c21GT1pWdlc0SkpWbzdqenhlZEIycyt6?=
 =?utf-8?B?cjJ3UzRBekFEU0pTNUpIZjJhWDZBQlpuU3lzd3Z4UnFXS1VGcDNTQm5lOEcw?=
 =?utf-8?B?eHdta3htSkVOYjM2ek0rcWx5RC9NRS9ValpTYVYyZW81VjZpWWh3eFg2UmhM?=
 =?utf-8?B?S3d4alg4Ukwya2dQUGJrUkUyN2VQN2VENldPdXhHUnd4M2RwK3BucmlhZy9C?=
 =?utf-8?B?bjJicitaa2h6VVBYNkdEeEwwOHdTenpPQjNhemdYam1HeEpEdVlBUEMvZDJT?=
 =?utf-8?B?SjhUaWJTZmlnWTRaR0M1MVJUa3ZvZzRzMVRmSkdRZ2dDbXFhUU9EWk5adktR?=
 =?utf-8?B?M3VGZS9pTnNHZkIzUFhCb0ltd0RXVTdQN3JOQlV1UlVLbEpnVVNJZFZUZS9m?=
 =?utf-8?B?NzVRaGtocHBxNG0zSUZaY0I1UlN3Ui9ESlpRVjV1MFIvNWxHWDUrdlNsMlo3?=
 =?utf-8?B?NTRIdXJ4OFRHS29vSE1NYXI1MlFiMkk5bnZ2b21ZTVpqd0t0SXNBSEJkMDBa?=
 =?utf-8?B?SEdZWUFsVXZDWjdvWmN4L2llTmF1cjREcXVpOEZleVRlLzY0RlFYNzBzdGVW?=
 =?utf-8?B?OVRwUUZHQnVqaUJYZGNsWExzaHNacnJHcE1keUlCckdqSzRmVkxhQU5rNis4?=
 =?utf-8?B?ZTJGdWd6YTFaNHNuYnJ6aDNJWDBhSFgvcDYxdk9FMmJCWUQ5MGl5VlI5bUhh?=
 =?utf-8?B?SWw2MElxSFA5d2swV3ZTcWJka05hM1MxbzJaakhlamJSQnEySmlMbXpsOUIr?=
 =?utf-8?B?Um5rbGdTWU4ya0o1NTBadGF5WjRCMkV2aHF3SFdkWXdVeVAvd05CMldUUFB0?=
 =?utf-8?B?NnMzdzY4WkxVK0svK2ZZcmZuWWVscFJtYVJhR3BiZWJmb0w4SS9hS2lNeTFi?=
 =?utf-8?B?RnF5VWs1ZXgzT0tyWTFBbXkvTEpvOVoyTmFrYno0cWdxNmpMMEVtKzRISDc4?=
 =?utf-8?B?VTZTdTgxZ3BobVVNV3ZSbk5KclFKZGgrdFNTRWZ5SU9wUW1UUXJ5c05nWk5X?=
 =?utf-8?B?TGZQdTR2VVJBQ0tmYkxtc3R6NkhoTlZxcjhCTnZQa2krUDRJWEtXbzZmSzQr?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ApI/MbhW4yeT/ICQdmBS9xWstvZO51EA7To2Ir9WnLGEmzltqhUUUZPPECiYy470FYqe3KWNM+kYq+ThVst34LzsnmkLP84noNgV5sR19MjPry/Af/G2TKo6g22X6kh1oQTe+3gBb9KTHRhi1LD1AbRielRKgdp4P3nj9sBaGCggcIpYlNkcSfkSqP8rH0v2zzAY0X5yqEN9NEpZ5X29WY5Ew+s3Wj+w7gXxgT1jXb1XNTrG+X71LJiRJ2rXbo/YcQpfTJhcfgsy3QYMe+o9VJd4SMJaEgxquTzxqgjizSBA5foDKJ+yX9Q6IDDb2NFXNa3ZQ3F3qmgr2tR4lNu0l4+XJE7qLVDr8KtSOtavpXeIpzngR3mCqPoSOc2lOKx3t5opyWAjYVq56m/8p9Ev8C+lFLZ5Gk0hIvAa5f9DrsBy8sLGRN7OvkutY5BTj0LJb+4lC7Ui1inlFyhIzAkVAJT5Im3N+KON3Z0z1m91LbmhOtW4xEOQg0VaSsoxlDam7xek/oaChLCmsWQ892TEsuJMGvYxASMH3tfYBaoBTTJT1daWQA0SZl2/xWfQ4W+6zM5HXypd1bVx7H/4iPmCXvoodiscGc2WvnIpQeB+Wjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e93c82b-0b23-4408-da55-08dc7b3f10b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:43:17.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YumgpK0wMtgcJNaerfRsTjVKIv2lITiMl9xG4T8oGfe3NumBpJK5oAnW733Fn6Th07apXEFRBWt9zmJ68pQFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230107
X-Proofpoint-ORIG-GUID: y7BDHLaS-X3nYneTbetnNX3y713IWTeh
X-Proofpoint-GUID: y7BDHLaS-X3nYneTbetnNX3y713IWTeh

On 07/05/2024 15:06, Qu Wenruo wrote:
> There are always attempts to auto-remove empty qgroups after dropping a
> subvolume.
> 
> For squota mode, not all qgroups can or should be dropped, as there are
> common cases where the dropped subvolume are still referred by other
> snapshots.
> In that case, the numbers can only be freed when the last referencer
> got dropped.
> 
> The latest kernel attempt would only try to drop empty qgroups for
> squota mode.
> But even with such safe change, the test case still needs to handle
> auto-removed qgroups, by explicitly echoing "0", or later calculation
> would break bash grammar.
> 
> This patch would add extra handling for such removed qgroups, to be
> future proof for qgroup auto-removal behavior change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied.

Thanks, Anand

> ---
>   tests/btrfs/301 | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index db469724..bb18ab04 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -51,9 +51,17 @@ _require_fio $fio_config
>   get_qgroup_usage()
>   {
>   	local qgroupid=$1
> +	local output
>   
> -	$BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
> -				grep "$qgroupid" | $AWK_PROG '{print $3}'
> +	output=$($BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
> +		 grep "$qgroupid" | $AWK_PROG '{print $3}')
> +	# The qgroup is auto-removed, this can only happen if its numbers are
> +	# already all zeros, so here we only need to explicitly echo "0".
> +	if [ -z "$output" ]; then
> +		echo "0"
> +	else
> +		echo "$output"
> +	fi
>   }
>   
>   get_subvol_usage()


