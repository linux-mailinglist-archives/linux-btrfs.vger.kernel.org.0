Return-Path: <linux-btrfs+bounces-2339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8D852578
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 02:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254311C23E64
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 01:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9AB651;
	Tue, 13 Feb 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cbtg82h7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JvpQFPRD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21561AD5C
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784575; cv=fail; b=dLTzEHEqYDneDDyvuIsZiz6oeeDM0HzeSOGl6PikTu59ANq9GMNxkdQplN1GtqN9yx/ffCNSXGZwzF1i/zJE7xfo38rU6hy2LR4qUrBQpYeZG6CZ7FpUAbQGeTpmlQ97TdcEbM+R/qIrLQYS3Bjb7Oe6553zYBR/etGZLLC+PyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784575; c=relaxed/simple;
	bh=lAbKZQB0pEgGikfARRBLAiXHorLZ5LqPk3L6brQChwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kjadnjsQv4H0ikr6BcU5XtI5Z9COxGS2W5VhY6g3AOcvlSJgIrQvVdbICZ0cblRbfOf47hgWrVkauPHkHpZhikW/j3gPYj/yIv0aYG/5xwwgFE2pg85BkHFWMMCXGXFl7zl3LcJCfSXuoBAEgCyDFNFsBdC8vq3BdHayzQPX4FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cbtg82h7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JvpQFPRD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CNnsYE022755;
	Tue, 13 Feb 2024 00:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iZkBx063SXX82FoighoGnzokTJn/IwhG5ENDYI/YQxo=;
 b=Cbtg82h7XTtAvR0m7/28nFlXMj8QPpgmlzM6eOcMw5++K/6ZWWoYdcGeTgM6xcWviJbc
 qyJxvKoP/jelDJAU51XF1ZwBmv1aKAexG7RGS0wP7Cryy6Pxq57gTzmwcyFyoy5qI1dQ
 OgJr2ujQeR5Y1uQOBijMQLLAkJ5cgMfNS9LKdtEGcN7d/Ms6tM/+F58coei7wcnjKRWZ
 APOfHWxhwJfpb1cWliDMFGkzI2iNZBPvlr44d/hkbgTuh77TQemdL3DfaoLXEds/xrYY
 1TslGQpBuU0ueiNpAhozd5jLQBDI8pUxfXasHgK2/Z3Ovz9MiZyCzEBQRSfu2aJMy/iF RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7wbpg23n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 00:36:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CMkJ6k024548;
	Tue, 13 Feb 2024 00:36:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcttc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 00:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/WPqS4NrNNPHN43vEIbFpcGZfbL1Uzcq5Os+TN0xBhLo+F/oQCtmiWP/eH0NBJmynZJo9s3MF0bqwwp0ZL1wgGFeJTumDBL0BkXRpY45lg+DpbuEUgn6TkBEqQOU/y2AcIcIDOuvKwOrtBnSjGbKaTVctbJdNEThwnjlHJ04YFSWrr+MPDi+aQdY2bxLArc0qt9KfBWZ1dYAdOmqCtxKZXD+6lPLtXNmxHxGHnxXNSOpi2pL28t49R1mDjQhK1NOzVpIIACLidZQ29NFKENMIYqubFskt+MUYOToHiunkKJDddfApoBLu6rXFWqqQ5M3vHjI4Pf5BK+QaraRz5SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZkBx063SXX82FoighoGnzokTJn/IwhG5ENDYI/YQxo=;
 b=WHZgMlHfIQ1p034SUHnVs/2xPYI/qWtL1ISZ69DJ0IK3DDde+VbKVzP2cVuEecsvsVAAkBa70aH3+cmWNLdh5xjLSWcI9YMtHIcrf5mNGHawJ2vAEYivEufOTckM8NyRK5zn0prqPW1h2b9lEyhe70hiX46yBmBw8VetgziIndCK1SYl7lkT3ws9Jhj26nWERuKaTNVb2Q1B0BHvsILDPoDQpEX0eFMgUAyQQEao/ZyDktGugJW1Qb6Zfg6H93M8UtO4mvNX2lU4Pk9qp9jIrGwBqMUXg6KHb0YdgTDe9PDYVPpClTdFb/T+5THn4UGjotiKGzWD+w97o1rMaxHXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZkBx063SXX82FoighoGnzokTJn/IwhG5ENDYI/YQxo=;
 b=JvpQFPRDpcFZstlF+LcZd0mvLn4AgYjF9proE6wDPqyP148Xmnp+RQx2jIrIS/CnS6AEdDlQAnKRDNv0y7Q56ocycZmhNAsWargDY4m8pEJ/mRC0gM5TZZdgWkxS3gq6g9uL3mAADzQxmmXR6eKsvkSNDn3J2yWuSrWbdXekBm4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6096.namprd10.prod.outlook.com (2603:10b6:930:37::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 13 Feb
 2024 00:36:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Tue, 13 Feb 2024
 00:36:01 +0000
Message-ID: <8b5c55e0-c9f5-496f-a8ff-cc8eadf64840@oracle.com>
Date: Tue, 13 Feb 2024 06:05:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240212145931.GD355@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240212145931.GD355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb3acd6-6808-440c-0e66-08dc2c2bc0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QFU5F4mbZyCDlhTz0CargFOxFZYT2fpMe4jsxcKiF2dbVyDGnTiEjvZ+vXihNFWfGt/E+K2yDsABUAjfN4AOfxgyyeM86p/OWTtKuaxBnkC5l8pzid79+z80xBqud/oC0+D38ZcFpzSURohgaIcqOop7svjrbJSygQYFEc4J5pjSWdAsTtqrNqxv7JT442Z7T7qzLso1N6Uy2gQnjl9FXE+4VevDEKw1rwet+nSFW6/h/w0ETkiTXbQbhgTwdaZR/9lCdhgI9hS4CKHXqSy5aBEY7LLqw3uYIVKUKpxXoKUhAl8rixYexZDwxq0LR6Wnuj0kIc3BhyjbDoRNRCf/lpf+lvrHtM/N/FFs9d3wgy9GFzgNDw70xY81BsD987ZFt0onkf/HgwSe/kKpiNIT4wGzLZUw3Yf/aikLsI0NPIxk34DDWir5cSIjMAAcNo6yqc4o9XzDDAepdOfPlXFJoVSzpBxbSCcBa36c7P2kK4PkAcDXhNUUE26FH7KFJ1Gh7jgHYVHXoDy/tJvdIRZFZk8d0cgXgrp1b7YpeMCRM2ap8neHqd36zuQAWKUo62Bv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8936002)(8676002)(4744005)(44832011)(2906002)(4326008)(5660300002)(2616005)(83380400001)(66946007)(36756003)(86362001)(6916009)(31696002)(38100700002)(53546011)(316002)(66556008)(66476007)(6506007)(6666004)(478600001)(6486002)(6512007)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUM2QnY3emhyYXpER3M2K1JOcmFQOGI0YW9qMXNrWHlva0M4eEdxK1BkYlp5?=
 =?utf-8?B?aHNPV1Q3bVI4V2RSRStIY0Via1FaTXBjUXUwWnEzcFppVWx1VWlveEJVSDAz?=
 =?utf-8?B?Um5XU2h1ZmtlSk95b3ZXUVZiK3QzVWFEV3UxWFlhVEdsak9CdkpqMGU3ZXN3?=
 =?utf-8?B?SktPRjNqb3BDRTJoeTI0VktxNjNIY05oTTBBV2dRdlpYVjdRZUV6ZThPZ21H?=
 =?utf-8?B?SVdLQ24wdWlnczNKZVBwbmZKRXdrSkN6MWx4OFVCVjhBTTFnR3EwcE10K1Nq?=
 =?utf-8?B?UnQyWi9CQUpiTEU0TG95Vnd2MlNxRzVEaTA2RklPdkpMRzdtVlJGV0R2anEw?=
 =?utf-8?B?NDRzNEhDYmlaRkNvcjgzcU8yTUd1dUZpa2FnaFc2VW9LdEQ4d1V4WHVaQmpq?=
 =?utf-8?B?ODJCMG9FaG43cndHbU1ScXdDVEc2SE5sbVZabEZkL3RldWZFcXRpNGxGRENy?=
 =?utf-8?B?ZjlsUXF3SkthbmZNeXpFQm9vemZ5aVBueEtVZ3kreHpUYWNnbkhybmpMMkla?=
 =?utf-8?B?YkxIZEJETXhJM2pteENxYk5jMjh5Y2p5RWFOMTdqNER0RUVuc2pHdHhlRjdW?=
 =?utf-8?B?dGk0bjI0b1FWSGErcHU1bi82M3cxRXptcjc4WGg1RVFSOFFaYjIxblg4UnJo?=
 =?utf-8?B?b3ZhbStvUkRmSW9SQ25aVzlXdGl2alNRUjBZaW1DVm5yeFNLVTRsMnorYVJF?=
 =?utf-8?B?MG5UTnpPQ0ZEVTMyekc1cHJJSVlTZ2RtSXRJMEZ2RGloT2w3eXNHWW1LRWhu?=
 =?utf-8?B?NWRRMUNUci91MExuWDdqaFM5Q2RkY205V1NnV2dGdW4wWitGTjl0Y3IwVk90?=
 =?utf-8?B?NDN4LzNwL1FuNDhwTUhicnNIWm5URGEySU43OWFORFJ3NXNzMVNwSWtRSDdB?=
 =?utf-8?B?ODZ3djZ4bEs5SGlvdVFTYUNjSUF6eDhxR0tjNEJnM0xzNlFDYUc1QTBpRmJj?=
 =?utf-8?B?TGswQ1gvOE55b3NTU0F6T0tlVkNwRDdtZkpZRkpqREJtb09iT01aa0FKU01K?=
 =?utf-8?B?RFlCVGp4ZmRQWGErZ3BEblJ3WWJ0dFdEaWsxa0l6OU9SNlR6Uk9JSkVGRWxt?=
 =?utf-8?B?dmpDajZuUlNaQ2xueGJEL1VjRk9PYnhRV1dhMjR6c1M4cE1FQ3Nsb1Fza0pC?=
 =?utf-8?B?bnE5WDQzKzhEb2dqZFRYQ0RLOEZEUU9kbVhKWVlYSk9xc0x6TUVmbmpUSWhs?=
 =?utf-8?B?ZmtRUEMzZU1mOFlGUyttTFNJZnRMNE55WDd3THR6bVIrMkpTK09PMTU5bkh6?=
 =?utf-8?B?clVVc0F5TjNBdGRhbWVQR0J0SjNlZDVSWmNFb0I1RVlFY0pVVGYvai9NUXUy?=
 =?utf-8?B?cG9NaW5ZYTZ4enY5V0F0cXp5RXBJLzhvQjZEMmhWdzhyM29DZjExb0V2Q3Zq?=
 =?utf-8?B?Q1A0RG1iM25CWXRYSEd5eEI3YTNiTkpDVk9CUHhSaldlSnBGYTMyZGVkb29N?=
 =?utf-8?B?cHpORzNjS2NLeEJ5ai9EQ0liS0FPV3pJSjYxK05jYjUwK2sza3prUkRNangx?=
 =?utf-8?B?dEhsY1dWdDJXVnJWaWdNclZFUjZoQStweEtqWWN1bm5GZHcxKzBlTlR2R1lB?=
 =?utf-8?B?aXY5bkR5RDVQZ0JpdENWQTB4SlpuZEUydklvQkIwdFVPaXdHU09aQkNzT3Ni?=
 =?utf-8?B?dHBRRWJkSXMyL3FRU0UrYlJCdWNYeHpJcXlUQ05McXErVWdtSXFCNk44OXMx?=
 =?utf-8?B?ZmZMNU9yNEdNWTk0WSswcHl0SHFqT1RzMWZvaTdQVjQ0WjQya0FzZUxKOVBP?=
 =?utf-8?B?N0l0aUdQNnpLc0xTdjdaclltRVpQNU5kcDd6RDhISjRUdzVxajh0REk5M29R?=
 =?utf-8?B?Zko0N2VpNUd5SE1Jbjlwck4yNVNJQlp1OGN2M2pHVTNRa1lzRE9LTEc2R0Jx?=
 =?utf-8?B?RjY0TnRrSkF2TnhINHVSdXdXV2RhK2x1cmZHcENtcHc5UlRGUm55OTVUQVZK?=
 =?utf-8?B?VXJNVngwMjJ5dDJqZXBZZGEzRjVxRHovenp3NUo5eE9VZGhML2t2aFdwRWlP?=
 =?utf-8?B?V011QTB4VlFYTDFXeGdSQ0tkWW9xTjhUZnR1cmxhZVdpOVdhL1BjVTMzZDhZ?=
 =?utf-8?B?S0s5R3BVL3Via0gxbGxMQWZIbVZMcnJaQUpnNEVkMkhBNDlDcWRHY1NNdmlw?=
 =?utf-8?B?ZUZJQlRLTFF5cTFzZU51Q0QyM29ZNE5zTTdXRHBSOWZFdUVvREgvOU8vaXlp?=
 =?utf-8?Q?r2B+4BO7cMg3oS8Y/kIOngFV1l281H/DdRPw4oGw+j6P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4Iexom7bqGeEQn71Bm2gMzJfRrsBobM8BMakbL5Um2JcI4m/0y6kQx50WQfOEW7TWuC46PnwRC+XxhEYbu+HptNVzVdnlBGgiVlE4Sq8MapCdtEVTlLr1vbcS3pjXqGzOV8uuPz9cO5ji+qLKnAh0BLryVR7Mta7Cb/WTIlWHWhL4g1lHS4KjSP2Yg3+3/jqVMkEIpDBC6BQVhKTwCj/TY+FcLd/3AAqbEI768wHgnorjvHB9QvYymnl0cY620x7NTN+oKC1k26OlBHSk8iFvxogW4WXd5EXe+Y4SA8VN7iePlyrqRNBPKCUdPd2Rxm3J8EV44iwnAM9Q/Q9rnWxdjRzWB2tdxneKviD1zYLqx3V3cvWt2FV93GFgRurk8iV3RuH4jQMUPti2Ek2+WvlJibqdrMcptApqyIAfpW5A1K0GyE6gi/SO4+u+k8N8vsuzU7inltcOymmLEG+DyLi3s3bVn9VcHcTswJ+tJRK4apE9F0LhHuYFP7WvyWUReiRlW7YE/tTFpKDVPx00rbTc8YAVPdBIps/sH/CCQco7efn2OwsenpZ671p3qhAk7ZAu5EGTtEQUQ49py48o2ms5Wiix8fiIsvxMt2pqOyhl3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb3acd6-6808-440c-0e66-08dc2c2bc0ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 00:36:01.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCJjBGBMk3RyUZ5eLpxjFw61ejSHoBhhlneQ5XFY6TRKl6CrBnFUPY2QX/NHOb82eEwHuUlIhP/8LsWAZm9FNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130002
X-Proofpoint-GUID: S4cwHKodS-vn09xN2oFcWBiA6aajkot1
X-Proofpoint-ORIG-GUID: S4cwHKodS-vn09xN2oFcWBiA6aajkot1



On 2/12/24 20:29, David Sterba wrote:
> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>> We skip device registration for a single device. However, we do not do
>> that if the device is already mounted, as it might be coming in again
>> for scanning a different path.
>>
>> This patch is lightly tested; for verification if it fixes.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---

>> I still have some unknowns about the problem. Pls test if this fixes
>> the problem.

It is a mystery- we didn't see
    "BTRFS: skip registering single non-seed device %s\n",
in the kernel messages.

Do you have any clue?

> Seems that we have that tested by some reportes, I checked it in my VM
> setup that it works (fstests and grub2-probe) so let's add it to
> for-next. Please use the changelog from my patch that describes the
> problem and then add description of how you fixed it. Thanks.

Thxs for the verification. I'll revise, send out.

Thx, Anand

