Return-Path: <linux-btrfs+bounces-3431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD4880342
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976561C2227F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2019479;
	Tue, 19 Mar 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WIPT1DEE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RyGSePWD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA539171A1;
	Tue, 19 Mar 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868656; cv=fail; b=T7lZCJzoARavYSv5naxw5bNxFRNGmsRnjRsqyZpvg/tx62yRwBi3ctW2LrO1jpw/z9QBnQGzjOCyzyl2jINqW5wTPi2XiO+bSig+8jqKiUhPvpJ0YvVGopwdmT0zT1i/9PVhq7Ote1d+mp85IGaGXLJ7yA39nI+yUvBS8URFCsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868656; c=relaxed/simple;
	bh=11TTZOHFWTasfw3AZ64IDqgoMmgebv8fMgk9h8AOr4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYCik3ZXoM3BDVkRKG6aaAGwHtO0trMsjxRpmx1bWTjg3CMyLCtgCEhJeRi29+MD7IVcITYoHDa4nUjDFMEtQ4GKaHK4KSnFPKc8qYY1byJHgIkfEwu4/9d3PfI/LdfEoPzXQrF17LZdz1yxERZ4tHgsOIxz6CwEMQ0cFSUMtes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WIPT1DEE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RyGSePWD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JH1r4n005145;
	Tue, 19 Mar 2024 17:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=n1d4v0AdGxodgcV7+Wnq9G231u6k2SHqNyqpvZQsUGE=;
 b=WIPT1DEEJEm3YZFz0oCudFs/XjzAJL/fwbRLcDMsVevktvtp+zyRcLB2hUgzzB5gIO9d
 M+/YRwCWHzkO+eBa09N07hS0hkuap6TKTIxYMNE+WHeu2v79Qe33l/69mKTWc2crIQZp
 JEgiYbdSktYkLZxgUj8UyezXk+GKcOkHYG2V2x7Hs9olvz2+lRILCmCLKZ2e1zVdL5c2
 X53n4o7rpRb4JJ7QeNTlY3MzUReHCee73PUHTE5ug3FxEoHC1DnZoYbW8V64Qt8oLozl
 5dULwY72M1NapVcEAti1Te8nKo4pmL2E7fS6sEtkl9ae/eViu3HD9Tua+uweYDpIzFMx hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tp60a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 17:17:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JHAkdA024175;
	Tue, 19 Mar 2024 17:17:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6ur5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 17:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fih0NJx8AZ1SpVdEpNwGuVwfxhG5UJw/uhuHzzXRUuQPRzPNvsiI13uyN2SwkLHipZcU6IXu+WMuHgpeh7FIoR8epzv/mnksqCGT46iH36SJOI9PpkLWXwMVLZ+ZpY5AcdanJzVPnIGrHRzO3bNDfN4SteZcPX0MOy+35sIArDwol4cS3TbffsU3euiA7wMuNj064k9DMVcp6aG7PN+Fe6Ce9t+dF/MS3eDmsk2GRdtlkAxRY2P1TW85CayQBROI9+3Hhxiv+PS+hxjGk5GO4vWmNZ28qSnEr8r2YVo5DsGCsmq/L8zvUqLUiL8VQtuHvvmD5N3YTbAE7LDgLMpNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1d4v0AdGxodgcV7+Wnq9G231u6k2SHqNyqpvZQsUGE=;
 b=a3FDQJ+M8mEywkmtTblWrA5tO13d6gV24wtbeA714tK77TcN+2pMo4sNS8dDRXzDjtkpbTqxyhMfRRcg0VuVPHno4cCV0byoctqbtL8rMZjfaefuIoyYaOZYjLc8g106R+LYeJeOfpnr5Ys1eHFGNyY7SSEcuFH2kIezF2oMDPZ2xFdmb+lOtzaNCSN2omdU42VGI7SWxOURQQ3It+b0sCfktoHuKi+E0g8zUaCYBKDM/uJH6o45zCZSRojeXRuq9kXt6+xmEb+9VYWm2XO326V9WZVok/LAvySW4/gMyGkkbwnAsE9Y0P6W+N64tZ+5g/FA9RhZmIF0uaeZCckzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1d4v0AdGxodgcV7+Wnq9G231u6k2SHqNyqpvZQsUGE=;
 b=RyGSePWDYoH0+0DOudPvzbDrj2VIe8B5t2xca0hOnOQl0L8daz/bRuMMK0TYeg702bYW1VEsyd6k+E4fyBjujTVUoBmn2gW5PzOxTl6671gt9heiZ+SlFIrxv4/srpc1suF/GOXhdjLgGknBYC8qUHURJiJqb//oZln9dfUeFP8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5568.namprd10.prod.outlook.com (2603:10b6:a03:3d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 17:17:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 17:17:25 +0000
Message-ID: <3d95db00-767f-4b46-9185-0f0d564c55df@oracle.com>
Date: Tue, 19 Mar 2024 22:47:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] shared: move btrfs clone device testcase to the
 shared group
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, fdmanana@kernel.org
References: <cover.1710599671.git.anand.jain@oracle.com>
 <440eff6d16407f12ec55df69db283ba6eb9b278c.1710599671.git.anand.jain@oracle.com>
 <20240318220219.GI16737@twin.jikos.cz>
 <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240319041633.l75ifryeidjxltat@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff2731f-e09a-4cdb-c631-08dc483871fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c50pBq22+KJtfEWPI5ewd0cD34Ywuv5NZcpnGtZ3NkYpADQq4sbnBnfm703THCTvhwFLdsO0jbr+WOKHH6A1QR27neHvM84rjthgoxZ/VbUOTKofsr6RRWY/68zJx/dtdso9MgXu/qWyTvLabLLlJO7g5hhsRdFefnYui6DYtxh5jkFS/CjNd6tdP8z4H4jcf1HWQUPWhUlSAHhLGhzAgX1ooAi3QlYHpssxoeX6zmHPDj+k8iLPspztlFAiHEGOerk8dPSxGAzrfDo4FM5UkVvskfhRfZOip71aE1e5mb4hgSEAjLLkO6q5oO8jqavVAZx/iIlFx/esUUMiidA3m2htK6AesxqocqPq8T60r81o+Y5Hl0o5hZly++VvI/pfNDWKoiq1pQczC6ukKWxAigh47NZ/FlXgHRfJirkegXmEi9kQhWCym+x41cn0pLakeOG/xmfE2iE/p+7UhZqnVcU8W5p+pQ7iLj/sJ5hNkjf3CQ/gTBod7k4P2/auVCr/GzXlbtV6Ye0KMFEw7PHt/guwwzTfEaD3V+BL+qQeUhhJOTJu3HtltNxrWibotGtJ7aXJeCqjHmcS620phOfS4UqQDrAKPU1QPTac8Ixcb2c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjBxdVZObVZBbFF5L2J1N2tmWThNZ1VPODJnNFhPVlFiNGlHak9CY0ZQem9M?=
 =?utf-8?B?M3lhMDZGQUNuREg5czJySlBZN2J0MHI0MFF4d3I5QSs5V2huS2MzRmdmb1Jr?=
 =?utf-8?B?SzdzSitjSHNvZmw4YXRHT290YjZCd0dSRkRqSlVIMGE4dHpkTGNocGt4clNK?=
 =?utf-8?B?UmdTcW0rZ3l6MzlZTWVPVy9nVzNaSjF2R3kyVTNnYVB5NlpPK3JZTVNUd1Bt?=
 =?utf-8?B?N0hOQm5tSDNpOUJDY0tQYUw2YU5aUTBGQkV6SzhwcEswaEpPdW1ybEhCWnlH?=
 =?utf-8?B?d1hPcFR6TitVelA3RWZ3RmhmeFhnTmVyaHRoUUVVWWVSK0pSUXVQMUY5Q2hQ?=
 =?utf-8?B?QzBqNHB5L1hLd29UWStON1BaMmVmYjQyRHZXTG9LUE52RGxveGNISGVvS2VM?=
 =?utf-8?B?MXZ0NDNJRVlmbnpoMnowVFhQbmZvQVYrU2tjbTJsZmZKRHhHcGR4a3dYaDEz?=
 =?utf-8?B?SlJBWmhaSms4dVBCZkh6ODBTbDRWYmlMRjcvdjZnOFRNQXorbGNTR08rem1j?=
 =?utf-8?B?VjR2Lzl5bTlncm5OaG1GS3NsVnZaaXl5QjRuN3JsemRtbVJPbjlrVkFOclk1?=
 =?utf-8?B?M1lJT0JBUmZwYWVmcFlxSlJPSlpwZVRWdzFWZkNqcEQ0NWs4OStBUFl1bndy?=
 =?utf-8?B?c2xUK2p5WUtKM0liTlJpWmdkOE9IVGpkY3J2R0V0OUQ2L1piVFlPMGpRbkJK?=
 =?utf-8?B?R3RwTmJlMkdsZzdtbkNTK0RrWmM2ZHpYZ3VVZlR2WXJRaU02ZDJoUHpvV2hv?=
 =?utf-8?B?eHFyT29NRjR6NjR4clkwZmU3WGt4KzBOWGxVYVFUc2llWTJ3dk0vYnU1K2ZE?=
 =?utf-8?B?WU5MaStPZTAwVWJhdUx0dkh1V2xTTEFsaG1zckdFV3pTTGZTUkZtVWJWY2ZO?=
 =?utf-8?B?UUsxS0YyRWVZZlI0WGViQ0p2RFZ3R1dDVlNnSnNvellUT0ptdW9rUjNjNXV5?=
 =?utf-8?B?Vkd0V21XVW5iSGRJMzhYSWFFZGlKZUlvcm5TUmwvTVN5WGNvWjc3azl3NXdh?=
 =?utf-8?B?ODBlc2xBS2ZXZnpqcVVsNDBLVW90bjJqTlRDY3RBcDFaSkx5cFVFNHo3bVBx?=
 =?utf-8?B?YzZ3M1NPOEVFWG5udXlBYVhFNlFEK2dDWmZyY29lZllHL3JCdittV3B4Sjhj?=
 =?utf-8?B?RnR6cWZyRU44SGg2STlOSC8yc0FjdGRZR2d0a1IwMEtyS29HOUpQZHAwWXRS?=
 =?utf-8?B?Q0ZKdHdITTg0YTFNSFZuZVduMk1BUWRGdHhsY1ZodWo0NmtHUU8ydFpnK2sz?=
 =?utf-8?B?c3h3M2dKUHhQMTkvOHhTMFpPQlZUUktUS1ozYUswK1JBd0h5QWdXZUVHTFhR?=
 =?utf-8?B?bnRHOHA0dFJDUWFkVGVTZ0Y3TG5WcjRBZWg1eGRLWTRzMHlEZVFmN2wyaUNP?=
 =?utf-8?B?ZkJtVVgvVFlQZFlMN1NidzMxbzRkNjM5WEp0UERidng1UGJWNEhnRXViTmhI?=
 =?utf-8?B?citHWmRTOWZaSHp4M2x2NThUb0gyTGc2TkpzNE95QmVQNmpkdjJibllFc3ls?=
 =?utf-8?B?a0YvTTVUYnlBdko2QmNnRldHVTNOdE9WODF2cmdueElUYTZzRmNabXhyczlZ?=
 =?utf-8?B?ODBQRXhvNTFmellmS2w4S1RBQjVBeEtzUHRrMmVSanRSRVpmS09yZ0pJODlj?=
 =?utf-8?B?czdqYTRWV1ptNUJmbi9PaCtKQXNieDUrVjgrQjJOTjF3MmNJU1ZYbmc4ZEpj?=
 =?utf-8?B?TFVnNWhHWHFKRjNOdFQzL01ES1lwd0JDSk5qTzZ4dTlQMUVVazRNQWRqMjRp?=
 =?utf-8?B?bGpPRGtxZWxJWVk1ZytFWE9DNXplQ3Z0U3lidnFWb0Zwa2FpTmNTd1k4ZGdH?=
 =?utf-8?B?cjRFSU04aVZPODdHTFVHYUtXbVdRd083RUJOMlh2QUNaYXVEV200MW1sTWdK?=
 =?utf-8?B?cXNRb05ra3lWSjV2akZFWWNXRlpYQUgwTFBXKzFwYVBoT1NBWHhnUzZIazBW?=
 =?utf-8?B?WU03R21EemRHTFZMaDc2L1NvcGhJQ1NqN1ZEZHpUVkFHZks4MnFQY2FHcWZS?=
 =?utf-8?B?L0pXcWQ5cDlxY0N1RWx0MHBqaXFKZnRSaWtZMWdqZVVVTGwyQnRLb0tSclJi?=
 =?utf-8?B?Wm1ac2pESDdHT2VxbjFJTUxqZmNEWDR5eUcyUWNNQ041cktpeUptbmw3MnJr?=
 =?utf-8?B?b3p3Z2djQmhWVU03eHVCUUlaM3ExVlc4ZHVGd241dk42TXRDSDJOUFNJcW5F?=
 =?utf-8?Q?Z4zAPzTKI1BfuGr+3e4ULlbuvm6ZzMmfrbiEJk2PnnUL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8dIUJ5XvuRuY/oXpeMaIXQ9LNwEN1/a7Dl5WV+g7/rojQLKmXa/owrY/do0mspGcbr0lYsjF+XM9osB16l7CkxUp7/E/UyZhuloBETSh+JjkROHYhRxHaJQFVBkK9WlWZ5wlF0BPq1zjW5S+u6/fAVggGOZctOGB0q2o5w/8DWsnkeHXZspMwpPS+Nty2CjhJlhECJ+2kmIRW7urIdO4CKdafqjMW7pDMidkeIkMTIHFQL7qznuh2CzL2UOsTiWhgW+o3FqexmgBuN+Nby8cSdSxIqkkil7i58N5nzA7cOkyKqZjn0HpeOGlTb4SLnJ86DoLpfZxH9vUQs/4vN7ghOS4Fe85sFVDROt0+vhmJt5Cpe8uSRU6zGLc+ry/JQms5tuZFfvPTSBHiLGw0prlJrVfVBNDkN2ih9bXsMEvz3ZescTcQBSCSw5b2IXvqGnqkjd1vmR/rWpZEcBtYlRBhRONLG6Ur4MuVGpezxPTF+WrZZP2Q+vvsD0hO/bIU+QSsYIjXQjhKNFCxwFb7YGcO4Hi/zqZT2ln5+0DYU102+qsi7qRM7lfSKXhTmgi2vQ+y4A3MOrlRCt2ECVYKHoJmO8RNHB85P9Lv05OPHOx5E0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff2731f-e09a-4cdb-c631-08dc483871fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:17:25.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3Rodn4rlz0c8Nd8ViT677hafyFP+bI63m0yLGBsKdZcLa7de4672FXnlDqX05BxGhEPThMfLrsy2QWmAoz2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190129
X-Proofpoint-ORIG-GUID: tvUY-2qnoJ39mwR1m7oEZR6r-u1EXm7n
X-Proofpoint-GUID: tvUY-2qnoJ39mwR1m7oEZR6r-u1EXm7n

On 3/19/24 09:46, Zorro Lang wrote:
> On Mon, Mar 18, 2024 at 11:02:19PM +0100, David Sterba wrote:
>> On Sat, Mar 16, 2024 at 10:32:33PM +0530, Anand Jain wrote:
>>> Given that ext4 also allows mounting of a cloned filesystem, the btrfs
>>> test case btrfs/312, which assesses the functionality of cloned filesystem
>>> support, can be refactored to be under the shared group.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v2:
>>> Move to shared testcase instead of generic.
>>
>> What's the purpose of shared/ ? We have tests that make sense for a
>> subset of supported filesystems in generic/, with proper _required and
>> other the checks it works fine.
>>
>> I see that v1 did the move to generic/ but then the 'shared' got
>> suggested, which is IMHO the wrong direction. I remember some distant
>> past discussions about shared/ and what to put there. Right now there
>> are 3 remaining tests which I think is a good opportunity to make it 0.
> 
> I didn't suggest to make it a shared case directly,

> I asked if there's a
> _require_xxxx helper to make this case notrun on "not proper" fs,




> not just use "btrfs ext4" to be whitelist :
> 
> https://lore.kernel.org/fstests/20240312044629.hpaqdkl24nxaa3dv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> In my personal opinion, the "shared" directory is a place to store the cases
> which are nearly to be generic, but not ready. It's a place to remind us
> there're still some cases use something likes "supported btrfs ext4" as the
> hard condition of _notrun, rather than a flexible _require_xxx helper. These
> cases in shared better to be moved to generic, if we can improve it in one day.
> 
> It more likes a "TODO" list of generic. If we just write it in generic/
> directory, I'm afraid we'll leave it in hundreds of generic cases then forget it.
> 

> What do you think?


Based on my understanding, here is the original approach:

  fstests/generic: Includes tests applicable to all file systems.

  tests/shared: Consists of tests supported by two or more file systems.

  However, currently, the test cases are not properly organized.

  Moreover, fstests/generic is nearing 999 test cases.

  Segregating tests between shared and generic can optimize group size.

  But, I am fine if we give away 'shared' to `generic` instead.


Thanks, Anand


