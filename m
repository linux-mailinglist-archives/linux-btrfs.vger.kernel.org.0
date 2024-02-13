Return-Path: <linux-btrfs+bounces-2341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1437852744
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 03:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E0F287161
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BB73D6D;
	Tue, 13 Feb 2024 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6SlAMT6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vROj6sDF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240917CD
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790109; cv=fail; b=uhrouc9qlYUIYzSNZ8T1v54rHdkoRI8L9cmJhKvYIR1CgAjxmJp8n9q6/HAiADg50u2QUyglvoK+YllkolqltYsKBvlgG8a2w/wCQQN5z62fnCYGSmvPxi0eV8MqC2ELoPFSonPaHZ3+3T/jeF0bGUXZ2L1U0O/0gZYPeR/Ojb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790109; c=relaxed/simple;
	bh=vby0z3nTXarqIYrnaKBWm9e4tE31bqVfOUobO4M31lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b/xFA2CFyspWu70lrtNzPMEiDbmK4SJl2Z8AEkZnHSvoyFmh9MhIm8nbzVeCUwbjGnAzuaNnmgUgOw0M5VVTzfmNTBDGePVYPPPrsrgQkuFYXXPcowG7TYQkZ/LIfXdyGOn/nzuDao+sQ4dnkYuDP+jl4TKnLljNMbcVXjlxsT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6SlAMT6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vROj6sDF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1hvK1017476;
	Tue, 13 Feb 2024 02:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6fEWYVfmWcHOCeyh+BDd9Vnjri6KJCXY+sQMtGFJ2tA=;
 b=f6SlAMT6btuvrXQSZCTIumFIPfHcoWeSfCKJ1x6Y0td/h8gz96T1Ew9JMWlwiu9Ksi/f
 SkI82i7aZheopoAV2oWQmkG7i5dBLxjuiXIggDsUdoL3lf9BDxht3Pb2iJssj6Fuxxrp
 VscdM88J4vqMKvkZk40VTVqZ44NkzFjqqFaJ+HACbjj3MW+288g96JP/iS4D/Yg07ioU
 ZeoaLKn3G95EXxV79jNEMY4u2FXmYaCAP/Zzkt7ty8Uaw1k72cEoPuY6lqcQX6uUSh1G
 fLme6BSNCg3O0gKtvjFaBr4TIv0nJp6g5GxeeltYZtCE5TW1mSHD5+0FT5iiyaS+lBnS oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xqv01e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 02:08:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1HigG024541;
	Tue, 13 Feb 2024 02:08:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcwf3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 02:08:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0FWBxax2DXBft2gZ7QcfxL+6FTbX68DJdOtteut4pNxL7rrm8sFD33kwPQJTM8QNoBdInoSmc51WqeDa/2Bk+HivE3Tasvj3UJVtJmbcMhZ/lyIxI9Sw2vR/e4ca26GB3TYtp7fn6nB/+gdSxpfBoELTRkJeaWm3e9rdUKEL8w9+3McEumV0yZSHH2GBY5EhPhWwxD+Zt+z98QRE6MaOW/jGH+uI6RviKrqjCqYE3C7Ns0bNxQlm2BS0fn7esOGf+PMNTyzc7d2MxDoJkVRejSn4G6+NJ+N7wlnbu9RkO+bukq2p5VOlPDFWs5fOYzT9L2uBnFB9jK9jL95eLtZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fEWYVfmWcHOCeyh+BDd9Vnjri6KJCXY+sQMtGFJ2tA=;
 b=BM3KQrah4GrhIh9WqaG7DE323SF3kq09OVY+h86WB8x5QnLRIvVszlfQULNYdLBfXi68ICnUJDL3Xy6H2MOScibGrklv0PFJTJjWUpYX1OxbpL2+aBzkC30oIGfeMMgSdZbo4XWXi/T1kDa8g50mK+oHaroLYX4u84eSWAEsljI8+ipNW3whQNQdkG/sSZJNnRTlL33ozamzWioP7yepnkOh2StEibyRNkgQYfex3vSSi09THaf1bN1OD1QmrDl3u+XDaKhVeTCIR3FUZThys6s5W3Bj0acNGN9kGCXB51wkpjiXY+ODtXD7VpVrBJPeDQPGm3VTI77XQ0TEfbwGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fEWYVfmWcHOCeyh+BDd9Vnjri6KJCXY+sQMtGFJ2tA=;
 b=vROj6sDFeFLlnuPv+yI/mViKKyTZ4awp6G/sYmm0vOOlnbWcJ993Xe1b/+q6FXx3/Pfitt2MrhUVLgfvA1Y5/xpB6+iTqsicMHmY5kENThO3KS23xZ8aPohwHnKXVkFouWQ3JCNuCEmtNJdJNXiQGB39YwOy44mWbEZlYgD54bk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Tue, 13 Feb
 2024 02:08:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Tue, 13 Feb 2024
 02:08:21 +0000
Message-ID: <52100243-8bba-441f-b390-15030275da1b@oracle.com>
Date: Tue, 13 Feb 2024 07:38:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: fix chunk map leak when loading block group
 zone info
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc: johannes.thumshirn@wdc.com, Filipe Manana <fdmanana@suse.com>
References: <0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9ce9b2-9432-4e35-d3f3-08dc2c38a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+lkfjOSI66ERMukFJyXlGEoFGdb8RQWgTK95d54VRlQUZz7ktY6FERman7xkc1j+BmhnQBQk9e5H4z/L/m4Eg9vmzLDWTDZomzhTi7wnQQag0x50q8MLUxyH5pG8Hsvd2fzylRxanMABCdN1ZoOhAGVCm/J52r0zAJQ+G0Mhlp8W8Kfh6ir942QQgvZFj7mvYV7YjPpnOhnsQQ1h386rLHV1nuWzneFCbvyzOcxNLZ2iiTUocgWtEP+Mk6SfZYxp649eRJsc6PlNn0LNUKwVuydegm6rnsbW2Xt2sYqU01vY/Ivk5N6Qs+U1m3pMvxham0zG4Ji3cx7YvMoYP5QgjuMG5yDIfSCfqgAht2Dc0pz5vgBtFBEpYPiMr/pCA/4VmKhOIE5V6tSsUDbTJTFMBeydxREPZjROD6xdIE/gz9rkRXyCVsQZBOPBOS5PcXA27+TNlqnuszjrYfK3ywP4Y/rTq4NQyARZvzPVCwA4SxceVBBnvcWFeqvLGzSIyt0yk2D+D2TOiKQo3Yk6I2s9bB5COytcPK9pukZznzg05KBkrObEMaJEA73PNddKISqC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6512007)(478600001)(6486002)(41300700001)(8676002)(44832011)(4326008)(4744005)(8936002)(5660300002)(2906002)(53546011)(66556008)(6506007)(6666004)(316002)(66476007)(66946007)(83380400001)(2616005)(31696002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXdoUFpETy9HVkdFamZ1V2VYWEtybmJ3Tkt1YjRNdHlRNzFDeitCNHlORmUz?=
 =?utf-8?B?Z2V6R1FMZzFKT2c0VlpvbktONjUvYmJicFlPS3J3bzV1VTl1OVhoQmZ5ZjNh?=
 =?utf-8?B?U2x5YzNxbW5EL2RzRWIyNmxUS0F6REhqL0xwMHYyNU9PMDQwTDJuRFc4TGZG?=
 =?utf-8?B?SXl3MStPbS92ck1aWmVZQVZEZmRRWEt0bTRnQWUyYWdqMm53dE8vdVBkWm91?=
 =?utf-8?B?RW5Oa1Z0cU8yd1IyYnMrUThsSHA5YVZUaHY2NEpCQ1pneG0wV2plMjlUQWRs?=
 =?utf-8?B?ckRVZ3UrYUNTNXhMNnBFL1g2NkdGeGI5UGdCM2JBSFdIb1BHRjFlS0h6a3Nl?=
 =?utf-8?B?VERscFI0ZzVkaXA1WVZHY0l2WVMvRDRxWWdZSGlZNzNFejJlOGJuVjh0YVlD?=
 =?utf-8?B?Y0FWVjhsZC84Sklra2VCamdsVTdJM1IxazZZYlRjc2JBNWx2cmRSd3Y2MTRV?=
 =?utf-8?B?eXNMbWFISnlYM0oxSDhlK1VyK1ZnM3RrNFhtY3BDQkNIZGJGVkZjMUZ2SHIw?=
 =?utf-8?B?VHNyZGNxUWJFTmt1Znp3K1d5aGk0RWJBbXdMT2VDNFNYcWlwZmJkNHpXWGhO?=
 =?utf-8?B?ekFKa1lXMlFCaGZ2dXh3VEJ0VzJua3VoQzE1ck50VTRpNDFJbmJsc2tJNnNJ?=
 =?utf-8?B?YnRBMFZlZUM1aHY3SngyOVZBZjlHOHFpYmM5U0FzaEdsZnh0Yi8rOG1uRGdO?=
 =?utf-8?B?WVhzdWd5eHlublE1MHlTUWtyeFR1UlFVR3ZLQlhaNmNkL2cxS2FsYzdlTTJI?=
 =?utf-8?B?V2JGaWVoUzErenNhOHhhRlBXZ2ltYTc3b3EvZnRQOTgyQStaZDlZUFAxRy9r?=
 =?utf-8?B?TlpnOWloVmF3dDluYnFUUUkxTFdIa20wb1FreHBlc2pNOG5rbDQzanBDcCtq?=
 =?utf-8?B?WE1KZEs1eVJPMitrWGZZc3hhQVJKTmNRbmVVc0pxWVZNbmYrZjE5SnZKT2Vn?=
 =?utf-8?B?TmVmUWlUUkZaSmh2Z2YwWTBQSzBBWHFUc0FQcnFoQnB1OXJHVVRadlRwT2dC?=
 =?utf-8?B?NzhseUtvWm5wYW00M29za0c3KzFZcGFjbG5Va0FKOGFPZFhKUnZvNGFiT05z?=
 =?utf-8?B?d0k3dU5ESzFqM1BWZ0ZCMUF1cFpjVlBvbHVRNEFiR2o0MXVFRFA1dW0rZmhr?=
 =?utf-8?B?eUZ5ckVjSUEwSDRSTjYxZ3YwMEhXUWRmNDdoVmpsd1hjSU9uOUZsUU4wMU9W?=
 =?utf-8?B?WEM3VGI5a1o2eG42S2Z2MVp2enlBSjFmalFQcDdHVkkyUEJFeHNEV1Z6TVZR?=
 =?utf-8?B?WWZyL0ROZ3VnZEd2TDZMdFdPeExpZVhYSkhGRkZtS01DczN1K3RHSHlZNGZm?=
 =?utf-8?B?YW5mdTc5WWF1Z0FyejdHYTc0MUJ0eC8xL1F5S3d5YkkyTWcvTkNoYm84NVFO?=
 =?utf-8?B?UFlVeVA4bkVPRklUZ1Y3NmpiTFNJTzloNjhNQlBzai9HT2dZM2VzcDVEUkEw?=
 =?utf-8?B?SlBWTzZqd01WUUlWazZRajZ3aWdkVWs0bHExaEV3djA4WmNEUE42K3JJTWp2?=
 =?utf-8?B?RkUyeTlLenhVZEEvdW8ybVh6L2VIbjRaVWRuWXZ5K3h3d2x0YjNUb1BUODlo?=
 =?utf-8?B?U2Ywc1NlTDl2V2FCZ2N2a0RMWHdram5XS0RMQ01TMWJNZzV6WTRTZmxYVnF6?=
 =?utf-8?B?dSswKzFiNWZOZ1hORDFjbFN0d3dGNUFQajl3bFlnT09TV3FOL1d1d1pMRUc5?=
 =?utf-8?B?RXhIMEovVjNyMExuOXlBSTRrK2dKTHUvSU9ZNVpteUgxYmVCUy8xRkY1QW12?=
 =?utf-8?B?aU5QNVMrSFhReGtaZU9IZXZNakdsMlNPcW4vVWRxRFhmSDdNdFg2OUtFdDJr?=
 =?utf-8?B?R3dYdVE5S0xDdll6SDFSOTlwbGFTd0JIZG9ZRk90MWQ4VDBINE9CSys1bUhn?=
 =?utf-8?B?ZjBQekZyelluV0tMb2Jldm1sdzVzMExXWUdxNENHRHpYWmxpbW9JcDRTRFJl?=
 =?utf-8?B?QngwbEV0U2RDM0VpRHBQQ05xOVFMcFFFU3NSWjdydFBBMmMwdmtWQThqc0Nv?=
 =?utf-8?B?bHZTZ2lXcjNJNXZiSHhTVWp2V2NwakhZWGQycmwwa3Via1B5VTQ1RmRNMlZ5?=
 =?utf-8?B?WWtxaVhwVWlySFpkQVlaTUJwem5IUFZxUGVVS01RcFlEMjhMUW55Zkp4SVM0?=
 =?utf-8?B?RjlGdTZqcUFVajdJVENZdzlrUDhxRmdTMnVtNXJDWk1OZFdKRU9LbXovd0FO?=
 =?utf-8?Q?4lg6Gh3r1uePAxdpmUKGLy/gF54LpCjSPgUWIr03C9JR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SgI/lDz7eNrTgLU0TBz8fVIMQZ+Meh3wD64U0A9u35c/unLZx7BCoiSTSnJDF4BzxekFB6cixYagSN1O7d6Da/zIO5McGf+UFN02oo9nsJrSujRllkExL7HaYW7pW5F/d3/qin8IDgaqIulneDbPXeiZduTuMVGDrm/lWyoKTxzGQuVv4thm48Ww0VIMIYzmmwgks1eSegOpKxVAGEHxVgHmRgLHsaz9Fb1eqaLDCWFWiVobjJBGNf5dDgVxbdRD7qNEZSghLdUizj+r6hSAlOZY3k2qeeiamRxT906EIGJIf8O3gtYS5kWoh2S9Ksqd4QHBOXqy66GdngQqIhNGcCoT9GSn8pkAA5lV6vPK58swcTd/xoC49ezPVmECNX+wNcJOLMXE9UaiIBf36LDZKzFTY+8movgJSp9Laex5klVz1g88e/LXX2PLcM2TA6/agGp0s4riQkrRD+2tpl8mMighz0Y4/V3XbziVZJ2o3KqVC0Y1oqrt5k48B+dcmn1CNlHZO0M7dmwjWZ+m0OaMXhKd8itXKVIOfVBVWyZzMLDqvwkbzgpZ6A/ptevsfp9zFkx8+1kEBX+xEHEs63PD7WoR1ko5AwpGENLdr9TiJ0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9ce9b2-9432-4e35-d3f3-08dc2c38a6c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 02:08:21.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7sLontrB6BS/U0f/cisGonP0aOmJaEcf66VSsSzkmlBM+y627XrIuBv1TiHt707JENRHRvm51ZST+HpGdjpdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130013
X-Proofpoint-ORIG-GUID: zLC_fMeiB2mkbxuQHQ2tpAak6crN9ixd
X-Proofpoint-GUID: zLC_fMeiB2mkbxuQHQ2tpAak6crN9ixd

On 2/13/24 03:29, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_load_block_group_zone_info() we never drop a reference on the
> chunk map we have looked up, therefore leaking a reference on it. So
> add the missing btrfs_free_chunk_map() at the end of the function.
> 
> Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/zoned.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d9716456bce0..46537d606dc3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1668,6 +1668,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>   	}
>   	bitmap_free(active);
>   	kfree(zone_info);
> +	btrfs_free_chunk_map(map);
>   
>   	return ret;
>   }


