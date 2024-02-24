Return-Path: <linux-btrfs+bounces-2705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D310862482
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01D91C2175F
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB353C06B;
	Sat, 24 Feb 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kB2d5v/i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YQpfrrqD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444653A1B2;
	Sat, 24 Feb 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774186; cv=fail; b=q+ecUTLlT11GDb0Zl5tXrpzC9KJbHqP4ALlSiFxBT9f+kgKAOnJZxtA38Q5uXdwjuE4uRGLllIXCw3gmGs0/rH4e5hQ1crlfLVqqPbguErvruspTPXhNevsPG6lxu9nCoUKX3fPmM6JpPtyg0dxy/h+3/kufaUmS0FrFOTDWC0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774186; c=relaxed/simple;
	bh=tLX5UbNYaIKcwqYs+t1Eyt+6uF4iJh+fPbthJ6qG/4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHh7uJQyLjgp/I5i6R7iPzemGyzNEI3irYpz8TSzk/rDlmu2PQn3vikbTdX4uy5ErdbmC3rNjdMNivlT/5rWgoYLspW3oqTJOQoRICmI1q3KrwjzxtjMscZhNChrgNtIFFWHWDb2ewT2cwcJwuIXkZPyBjuz6kaAldRCh7G84gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kB2d5v/i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YQpfrrqD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OAwlQN008867;
	Sat, 24 Feb 2024 11:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V4lPpYLI/vnR1NrtNbN73uKeHY0ybnF/lB+IJCz9PyM=;
 b=kB2d5v/iuSCRvBIzpCLbQDPLM/oo2U6GhwwlnJ0SaNnLRySivaA2bl1wLRW+tvNBCwm0
 F7g/7ALKqKRErITvtojd65q4KChKFF2ORcL9R+0hholV/+wsO/9AY2UQuu5aPPvFQ6jo
 iwjaOaRRfJrB1yBOzLN5/h8XbPPdPDdiGALNzOTiz64KJNDTXRGgUif1PoBGFdhZBjab
 S27mQzY/ntKBsXl/pF990PP0j5b863M6DQxgfyKYq3Y/WQdA4t9vpMzqNN+uPg07HsI9
 8Ig3AY1DRFt/LN+vnEov3SJroLe+9Z3XObh8/HYOCJ7nq+exR79EU5xps+Br11gqDE6u fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb0rvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 11:29:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41O890R3011458;
	Sat, 24 Feb 2024 11:29:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3m4va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 11:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVNUnEarrjtRz80INq8PjueP1YqswHizVZ+ypwJQwg1pXW8pgzEXcN5mcP8pIxywNWdSIR/21IoYU5M4dS0JEBswqQNqTE4ZF/qWNB0kC1BX1Q/4ew81hDh6qBmIfQ/rZM76S5gMks4WebCkkr08PLJYyW32RsbJSbDl07nDVGMlN4sE/qIEYIKzLPaRwDqhY+uGNqB6wvYiDAgxmbPbL6Ae2CjHUdzYJz1ZqRkGL9hkLsLFio1vvBBQHJVu1neL1VNRrL5cbzuVlxNd0/jQzjB9HaWytfhWlRm2BczVthSrsYM+uL6gwP1mjXxaRf9GQPlHdcAsaQs/r7ctwdjLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4lPpYLI/vnR1NrtNbN73uKeHY0ybnF/lB+IJCz9PyM=;
 b=XK7aso40eyQpPiot2QYLuxDZ6VInm5osAIHZTVqvLgR13yH4uNjwnVg2KepLDJiIxJjAaE+mhEqNtTRzh4rbeXJLlqVe2oDVTas7V20N9D3SX7bgG4/3TuFJWi87Bbspz+kWkNBqd5zY/1SwzzV7TjpPGZXyrfj/vZaDOYRrFNXIbYNy7S//29XTMycW1Fxd8a6JsHQgdcM/YL/V3+ZpJ+YjPecB4uAL0tuB2FTCASg6N4fWztJgFOIyUtRJ/CuJQumJ8nkQgei/AXSWsv/NhlASCMpRYC1JyLQ5bndixCGugW2qFYv/hZAiopJntOk38TYeL1mUH+oHMT1TgZO8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4lPpYLI/vnR1NrtNbN73uKeHY0ybnF/lB+IJCz9PyM=;
 b=YQpfrrqDwpK3WbXZk+OvCa40q8fUTC8uapNY2d7eNJaRl+wgyd6ogbxHrzVh8Cpt/Y8sI4D7xqCEmtyRpcAtFg8zo9gGWwakdWFb/xz8RPikxNI+seVEtQXcrtfhWLBCwHBXVmtFqj4wipv/b0WzRZt15+nYBLwNvO0J4R+86yw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6565.namprd10.prod.outlook.com (2603:10b6:806:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Sat, 24 Feb
 2024 11:29:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 11:29:34 +0000
Message-ID: <dbda0734-3ca9-4379-ac88-50d67180b538@oracle.com>
Date: Sat, 24 Feb 2024 16:59:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] btrfs: test tempfsid with device add, seed, and
 balance
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1708362842.git.anand.jain@oracle.com>
 <bd72599f2b44e4062262421ca52f83c3dedca1c8.1708362842.git.anand.jain@oracle.com>
 <CAL3q7H4tNZ5uLzyojf3rU36Pnsz3sWPVgQ6H1y+Vw8PtFCV50A@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4tNZ5uLzyojf3rU36Pnsz3sWPVgQ6H1y+Vw8PtFCV50A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5b9df3-86e7-4483-e266-08dc352be04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	10dHiMQGlIDJfMrptv6rzqHJZEPWxxSwidnmM5K7eOx0ISgi6GVUTI0W3GAntHEwQ3/qFXImygw7likqp0XUzJaRIAtfbBFkH1OhVX4yznDmXY4dT9PXVx8sbiDvth7OR4PHjQR50Eg1rXob8ioXYgaU0++s2SjN1hJtAYcXdzjSDrWKUkNn0cdVfuLYgRv01gOoAqZwf834/tJJBSUYB2JI9E94/U93g+IfOSzTdTH7rwlL6plYVxRVmLABDY9tUOxzkl2lJCYL9IhQbgh6IbhpnAZiUlcv8tc0oOtr+VG+kUF6cnYctHtrzCShVhhqPaKe0572JI7OmOrns/ILfybEdOehR8d186jHBwTVnQJ4Xn7tgSMKTv26mTiCFPuyRNBM/MmHJJwDCAuYPxUzzx/CH6iEuF3HGTR/wkh0Gmr5h/MTC/9ZKUhaSewm8ACRSbsXhtHk9rbvF61PSAfToni+1kJwyJ2wWZw/xGOscSyvMyLUgm2RUk6wrplDz05JlZMRX7M4og2nuUFuKPlypg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlRHQXFyL3g2ZldXMXdqODV4N0I1TmppSmhUcXNZYTQrTUZIU2Urei9mc1A3?=
 =?utf-8?B?aXZYaHgrdWZOQ1d2K2tKOEtaUzEzR0hXQjgwOEp4cWtUTlNRSGdZQWtZZXps?=
 =?utf-8?B?OTFpbkEyL2Q4dnRBSitBbUR3a0tWK0lPQ29lbDVuMHQ1cHM2R0wyYmZwMktN?=
 =?utf-8?B?UVowSWxvWmRxQlU1czh5cFBPOUlScU45U0hXcHdPTklVQkt0Unl1a1o5SW5o?=
 =?utf-8?B?cCtacTNoa2kzMDNRRHFhSFNsTkltMUJTMlAyVDY3a0hsemk2WVlnYlZHa05Z?=
 =?utf-8?B?Z3pSOHJIMlhDRWVqc20xSDNEUkxaNncyZUZFTW9ldjRVVElFZDQ4eDZRU2pw?=
 =?utf-8?B?K1hkMUwyUGVSR21JU2JUNWJzWGdWQXlpTEEwSFRNSjJ5K3pqYWlUQWFSQW01?=
 =?utf-8?B?K3krRnRsdThQUE1hRmFnN0djWFZYZXU4Mll0eWNlcHhrQWFEY0pPdFF3SGlG?=
 =?utf-8?B?aUxQU2RZZGtZMUdSaXp3NEZFMHo1MVJ4YjZTY0Q3cmNUT2tYMlN1UTByeXZ3?=
 =?utf-8?B?bm1sdkpGWVMzTHRyTHA1eEVnNkxGTWxNYXVOQWNJTkJOcEttSmc1R1o3T09y?=
 =?utf-8?B?V0Z1SzRWTHdoWkhwcngwdEt1M2J3S29Wbml1SmgyR0FkdGxFRVZId3J4OHAr?=
 =?utf-8?B?Ymk5S2VzMmxGQXJjQmRoQm5VK2pXbVFuWTdFVmlxVWJpV0FDMDBpejhsVEdm?=
 =?utf-8?B?aVg3c2dRdmZ0ekh1TXErOW5kNEp4cnlFNDA1TDBYY3ZXSUhOVUlYV0ovN1hq?=
 =?utf-8?B?V0grSklDR3RPOE5HcDVaRm9QRk0zZmN1LzJCN2xzWTFvMjdaaHh1cU1zcEJ4?=
 =?utf-8?B?aFVsZTZnMUR0TzFMRmFGQUNMZlllQjBOTXdtT3dxL2l6RDRJeXZHb3lpZWJL?=
 =?utf-8?B?WWFKT2VsVDRzTHkrTFREdnhmTjRxNWhSTFVEWVA5eTlQS3B3L3dXMmJOOXJY?=
 =?utf-8?B?QVJ6NHZlZ045eGVxaGVBVHJjamZYVXQ5N24rVUc4VlZqUmhFY0ljanljZTV6?=
 =?utf-8?B?RHp6Y1JCVEpJMmVmSU1VVURtTE9qbUtCelJETUczdVRkQUxKWjRsZGh0NTB6?=
 =?utf-8?B?azVQM25MVHI0U3hCYUZFQWdoNUxkZHhFYVFHb3dQaG04VlVjWnVGdmIzekRG?=
 =?utf-8?B?bVlGZS95YzdDeDE2SGxXV3AvZHpvazM2eVVIUXNCK0haT20ycUhXQzM3czRt?=
 =?utf-8?B?QVJRYUlTc3JpTi9GeElSWGx6b1A4OFFYMmRxaWNGbGw1VWUvRlNnaGZIN2VW?=
 =?utf-8?B?bUFZOFVqaGdFZGxvcHduTXVtb1RPVEREajFtSXQ2VjQ2eGkrM1NLK1ByMGNz?=
 =?utf-8?B?M1hYQjZQYUkvLzVkNFExWWRUT0JUYkdpZjROK045VW81anp0YXBBRlhkdk5W?=
 =?utf-8?B?cXJHVkNwSXRXdzQxNDhOVTBPRnVwakJpYTlsSVlES25uSGNsbUpOcmlaY2to?=
 =?utf-8?B?WmZQY1JVVnR6Q1hTMEZQWnVEVCtvdVhNenZza3ZCRXJXemJCN3F1TEQxaGNt?=
 =?utf-8?B?WXhCWE1hbHJZYUd5WjVkV3NjMjdET2hLUlQrY1F6eEtJTG44Wkh4OGhFdkw4?=
 =?utf-8?B?aEsxditQeE1qNmo2bDNxalhtMWJtZEdpK3BSWTdpR3hqODk2M2ZKZ05Fd0lR?=
 =?utf-8?B?eTZJRzNiVXp0cE1iNzhLM1dxMmluaTJKMTFaR1NJOVZZekZXbERJdnpNUzdh?=
 =?utf-8?B?WEJQZzEvMjBxM3BxYnlhSjA3czZ4bTJHVTZLSFVTMS9pVTJOQlZITUVGNDJ4?=
 =?utf-8?B?MFNqV1BTODZVQUxnMHZJOEpMZ3RJSzVJQ0VqcWhWR2VFYjFVS1Q2ai91KzE4?=
 =?utf-8?B?enZxdmlIcWo0RHJlRXRPYkgweFdhTkdDYm5Oekh3MlVQMjBqdmhSRHlFUCs0?=
 =?utf-8?B?bDB1ZGZiN1lwZ0Z0QldML2lrTm9XZDZ4WDVrQTN5N2x5Um15UXQ2ZGpWQUcv?=
 =?utf-8?B?TnlSY2cwSTZhUTg4OW1oWThUQXJDa0Z0d0JvRUswZ1JhV2ZXaCtNT3ZFbFJT?=
 =?utf-8?B?dWpEWkxUaVJnRHNMek0vTEhmNHV4WmMwK016Ti9uTFVGNE9McG82ZVF4K1ZI?=
 =?utf-8?B?WUxIaElsRFB2TjRscHlpRnExRHBxVGxOZmY0UEFnR1grWkNFVHBKeCtMZ3cr?=
 =?utf-8?Q?km8+VJh72EYgUBoZzBtAVzduY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LJX7sUQGfvjnGz+ZjuccQhDg3p3l2zlzFuYs7U4LqEp7NYkJOIPSWy6vFYai4oODKZmdtiQewDFzJq0Snq0KeF26VnVI9y1PmdzMSGA00nca5bbKEDN4R9UFdQv/ambjeVsydARCDSkiE7nrkHS+pjARME2uXywmdvm3Qnx4pCxqcqkfDh0Aj9h9dtHpkxjhs/UB4wiMT/4ubX3Bgcmp5fo7Eg81luhtEkYYLeYebuD9QjDA9Qxv3PhG7iszN0galGXgI8cIbCoIcqBk/VW30NkXsoS8N344pkUAIapZ74VSv11iauwxobpYQpVQjiVk83n4UIfY1uDXl7U1MHB4UhOfvcIP+Q9XFKldEq1dmghG4tgCKeOoXEj1oyypHzqMU77i1S8r2AcwBv6Vf0WgjscM/hypaZ//vn9kZ8PSRojhQ7miyxd9eIJXhqSPcrKL2nbD7BielCs1IjgNZmDQgpbtVWiq9e8WMNwpUhoPW2jiul8kzzVIV23f1MRyrKDbWp4C/6nj45WW88EF+vUxMXlFXiLx7JKNwiCMsVj+5+/5wuUYZnYw1Uu4JPWm3QLmGp2Ao+iqnBNRLv1yEnxcaZjcJS4nNNx970GSXNDvyr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b9df3-86e7-4483-e266-08dc352be04d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 11:29:34.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SL8bFZ2uwut96Pm2RAYze06wZXCG+oGzbFZQ73FBwXOGlZ0udH63w9mo1vfqJ2IN2HKqFQdymSptrmcBPPddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402240095
X-Proofpoint-GUID: 696-_PW5wQJrMsbGSzfoyZLBuSXeDOYU
X-Proofpoint-ORIG-GUID: 696-_PW5wQJrMsbGSzfoyZLBuSXeDOYU

On 2/20/24 22:35, Filipe Manana wrote:
> On Mon, Feb 19, 2024 at 7:50 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Make sure that basic functions such as seeding and device add fail,
>> while balance runs successfully with tempfsid.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>   Remove unnecessary function.
>>   Add clone group
>>   use $UMOUNT_PROG
>>   Let _cp_reflink fail on the stdout.
>>
>>   tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/315.out |  9 ++++++
>>   2 files changed, 88 insertions(+)
>>   create mode 100755 tests/btrfs/315
>>   create mode 100644 tests/btrfs/315.out
>>
>> diff --git a/tests/btrfs/315 b/tests/btrfs/315
>> new file mode 100755
>> index 000000000000..4376c7f1849c
>> --- /dev/null
>> +++ b/tests/btrfs/315
>> @@ -0,0 +1,79 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
> 
> Your name here...
> 
>> +#
>> +# FS QA Test 315
>> +#
>> +# Verify if the seed and device add to a tempfsid filesystem fails.
> 
> And balance too...
> 
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick volume seed tempfsid
> 
> Missing 'balance' group.
> 

   Now added.

>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
>> +       rm -r -f $tmp.*
>> +       rm -r -f $tempfsid_mnt
>> +}
>> +
>> +. ./common/filter.btrfs
>> +
>> +_supported_fs btrfs
>> +_require_btrfs_sysfs_fsid
>> +_require_scratch_dev_pool 3
>> +_require_btrfs_fs_feature temp_fsid

>> +_require_btrfs_command inspect-internal dump-super
>> +_require_btrfs_mkfs_uuid_option
> 
> So same as before, these last 2 _require_* are because of the
> mkfs_clone() function,
> defined at common/btrfs, so they should be in the function and not
> spread over every test case that calls it.

The last two _require have now been removed because mkfs_clone()
includes those checks.

>> +
>> +_scratch_dev_pool_get 3
>> +
>> +# mount point for the tempfsid device
>> +tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>> +
>> +seed_device_must_fail()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +
>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +
>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
>> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>> +
>> +       _scratch_mount 2>&1 | _filter_scratch
>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test_dir
>> +}
>> +
>> +device_add_must_fail()
>> +{
>> +       echo ---- $FUNCNAME ----
>> +
>> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +       _scratch_mount
>> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>> +
>> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
>> +                                                       _filter_xfs_io
>> +


>> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} >> \
>> +                       $seqres.full 2>&1 && _fail "Failed to file device add"
> 
> Can't we do without the && _fail?
> Just call device add and put the expected error message in the golden output.
> It's the preferred pattern in fstests in general, and makes everything
> shorter and easier to read.


Upon rethinking, it can be done as outlined below, also updated
the golden output accordingly.

$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 
2>&1 | \
                 grep -v "Performing full device TRIM" | 
_filter_scratch_pool


Thanks.


