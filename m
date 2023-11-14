Return-Path: <linux-btrfs+bounces-116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B016E7EA7D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 01:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BD32810EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583CF4692;
	Tue, 14 Nov 2023 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LuuZOvkT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UIOuQocW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC84407;
	Tue, 14 Nov 2023 00:49:25 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE4D4E;
	Mon, 13 Nov 2023 16:49:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADNs48a030165;
	Tue, 14 Nov 2023 00:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=LuuZOvkTxlk6Qty+xApvCN6Y7M6wQ8Dt+vyt1x9EteGJWuo4Jg1GLtDjhlwKOrh4wBdk
 P2BNpEFsnx2Hf/HG7tCBUA06TBs8Zo8J1jdxwWCGH1zn/NkLTDgTQMlGe8VIxJeQ3rF0
 TgBvGEUI/7f9qFX4qU70Mx2iyuSVlsma2CPVnELqEesFIFOnpe10gCuwXiKAD64Wa3Jn
 v3IAzI8v+YCSre5xo40V/qBDmzrZNcgVARSVM4IjDaemQb11XiZxu3lW0RlwQppRsPSl
 tGaR5cWlE7HWAkxqfjQVBwao0bbMpoR/rUb6CKv6XRudQmVanUalGxQ/WHWwghL0PXME Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9v3un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 00:49:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADN4OaY022846;
	Tue, 14 Nov 2023 00:49:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpxferk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 00:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf8d/sdlKExTnFf+pVPkfPJFWyOIjDOeGTnocAEaM4bKEl0JLqHygmd4q7uZ2hd2KMtin/JvJonAflt9bWzrdRUedI09rSItzNq5fryJMknmfpOv7BKYwmhyfxMeQUEqmuqQjZLiOptGuEWwJ1iJNnGsds8GDWNBn6nxRlm/YOqXRC33147nT3V5R2/R8CEQ+A7ZRYGgGbNkPyMzeIEr3NCOF99pHd2WNrD+VVbDhKq5uHyf8sZmREVM1dCqmBcmhdfTcXnMC0EVCXPFXdXxnqtin8PTDFZwwL+2vINSfyBiqCDtzw6Tv2bt5Gl+5IRs0DKCWnJsANVcixeRrm2h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=LSI7mwS4wlCtxtiQ4DNtqpT2xkTiZAKOzI5o4apLCBe8j3lHAyR2OrByYv0XTGt35N430sflcAqs3zzscqJGphlwNozjd+cDfFQjOv5c77MMNY/i9UY7B4nhpXpT2HS/lURjgVSZqe82+CEgvGAHNBJlzpMBxx3l0LcYEmwaJYMY+MCfIvGWpG80bHr7h6LK0EGbN3Qptxwqkk3LonxnPDDRcyWP5R+/hz0TpJ910sBZCPLSclVg2Q6ieq1p+3LQaVHkhB8kdIO2KrEItRtTZuPQ8uqIJPhEK+X+L/1iAdq3/wTvog+urmbHPkYS2rTZ4OAIpbJumi+gotDmkJ4zDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVJDunWLz+Xcykb4FZHQ3k/pcx9Ztn20GwEppCiHnKs=;
 b=UIOuQocWLIo41HqkxtraygGwdrnSY7civTal5PB1ZI7F18lsWmP52cP4AYPEGO+c77MT9QXY6FB8Txm+9/adb7UiGwRGBXFSt2mGRtClPRnlYe3Yo+vKkBlVxoOmrNmpRykZmJ+ebUQ6V0iKASwTWyE/ocBfljGr42EfBpZ6i6c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYXPR10MB7950.namprd10.prod.outlook.com (2603:10b6:930:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 00:48:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 00:48:57 +0000
Message-ID: <3abe2299-195f-47a0-9428-62c73dcb7d4a@oracle.com>
Date: Tue, 14 Nov 2023 08:48:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] btrfs: rename bitmap_set_bits() ->
 btrfs_bitmap_set_bits()
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org,
        linux-btrfs@vger.kernel.org, dm-devel@redhat.com,
        ntfs3@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
 <20231113173717.927056-8-aleksander.lobakin@intel.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231113173717.927056-8-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYXPR10MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fac8100-e134-4401-6218-08dbe4ab7c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IxHylVMK/V3QdKu7tDf3TPg+xI6gktryHdJ8Oqv6d/74irdvK+SJXkXUGGAdpotiOEhBlGWlAgfDMt+1QwQrSlAWZ7fgR72IQoudvt5LcQWwceLaw2wPsvMwBlXKzyJuWW/5JYehwEGPf/MM6beoBP2o0Q4p0tQt+s51NhwnNbUt2WZ4sU/qj7Z4ziL3VX98QvFj3hDqMb8Byw9kUpA/UxSjc7arh22zWwAoZ7rOGhlDAg69YuOGpkiCkcK7nChHqkopuk5JAn+pN+tIC8EoR+fx1MQPdgWsCDerog8XoqOjeN7g3YsZ+HCZSzSOh+yWy4V6qiFkf0wr3o7fAsBIRuNgzrr0p3K7ROsOIW2ip2aC6Ns7MtCn/CxGuQpm7i7q3imWG1WyGEFyJT6om4cRdaETyQ5xrcxw6iyNKkOLnrvWbqJXheG6CSN0OA04hKeuiTWe63U+XwxlQS5Zp5sgA8jfqQfJdf3U0jCZ0pxE7YIohvLhcMNorqxVpt/adn5w2H+bahKtf7cel18fXL7Q8xolpg+6UuQWg20z02siExp62WEz6ghHkl9RC9tz/BjN45CthBXrEek8xKCTBMhZdaFuxsosK0xAkov++RjYESNkvYb3YV2gPPWWZVGuqM2W7C/iovrnqujQA3lXRJcLlQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(26005)(54906003)(478600001)(6486002)(6506007)(6512007)(19618925003)(66946007)(66476007)(66556008)(110136005)(6666004)(4270600006)(2616005)(4326008)(8936002)(8676002)(31686004)(44832011)(41300700001)(5660300002)(7416002)(2906002)(38100700002)(86362001)(36756003)(31696002)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3hTMEd0T1pQeFJGbG9hNVY2TjNtVElOaUxUOFJqN29waThNZjRoMFdoQzU4?=
 =?utf-8?B?dER4djNBeENMem4vRUJUOWJ5VVRZUjNXamRFcklpakN0YUg5eS8rSmphWWVE?=
 =?utf-8?B?NUxiRHllNXEvS0NWTlRRY1QrVnJpdytJVUszeFBGUktDZDRHcCtIUlcwYzBt?=
 =?utf-8?B?L25zKzhlUS94TlNkVkxvQy96OVFuVGljUE9EczZ0RVQ3VjJXcEZrb045Mllm?=
 =?utf-8?B?OEFBRzBrWHVnc0RNS3ZLSVV0eUREeUF2WVFtaGxPelJIOGRISHh4Zk9VL0RP?=
 =?utf-8?B?Sk1FRmwxdzVyS0Z5T29tNzByN0FZekd6Rllzb3JEenlQV0ZCRHdBbmxSSXIr?=
 =?utf-8?B?eUwzQ3pPTFVEZk10ZmJUcTBtN3Z6LzZ0TUZmUlVOWkVDcWpud1V4SHRDU2xB?=
 =?utf-8?B?aUNITkdiOHp5Y2xLSW9yS3hZYlMvRGVHbzdGNjNqc29mbDY2RVU0K1ZPWEtS?=
 =?utf-8?B?VlFVNFZsWTRlZnpoTGxoSm9WYjlOalIxU2xsSGNQZDNYbmNSR1JDamQxTnRO?=
 =?utf-8?B?WElwRis5cUxSZ1JTNitIaGdQNFlsOVhBS3FTWlhYZldPdVlGZ29EWmo2ZEk3?=
 =?utf-8?B?SGpQTC9ycEdaTkR6ekg1RzhHV0FSZUVERjBWY0I0bzZUam42bjhsTXhQRkx5?=
 =?utf-8?B?bFlmdXV1VjdHYWVhTEk4YkZYTUwwdDA0MnhBTmIwczRSZFdaQ2c4MEdZSXVN?=
 =?utf-8?B?Z0xyL05CeC80SDJSdXpVd09HUmdTak9GV3g2U0xnOUVhRk9YVlIxclpQTk9k?=
 =?utf-8?B?UGsxQ3ZDTnRzZjZwdVlPRDZ0bjQwZ0FRdVhaa0s5RUZaTDFYdWNYWWxzVW9k?=
 =?utf-8?B?TVI4czJMWkxrd1VVcEEvNThyWWttcW1YdmpEOGNJcDhKQUtxZXp6TnBJb3Zw?=
 =?utf-8?B?OWllcVpyNXJ2WWlHTGovblVZUy8xc3UvejhSOWdxZUFPbXpyT0MrYldpcFFn?=
 =?utf-8?B?Zml6dVpLa3F3aHBsR0theC83VFJlc0EwZm4wTUxGb1cxNjRUSGpocmdqbEZx?=
 =?utf-8?B?eEhGT1lKNWZBL0NIMkV1M0hFdGJ0OTRwNUZMN3pWb2h6K2VHYTRCVGFqc043?=
 =?utf-8?B?Ry9zRms4YlhnVmV5bmZzN2dMSmNFZjhLeXJ0V0RGVmg1STJQMGRFc1poZlps?=
 =?utf-8?B?MHRuaFg5OGZMdjhEdGZidFN1eGlONnp0enVOcjZQelpidzB2N202MUxGNHpD?=
 =?utf-8?B?cFZaWDc5R3U0N2RNdTBYZTNnRDFSSjNKQ0ZqK1ErN3Nja1gxMWU3RVlLdHJs?=
 =?utf-8?B?K1FqU0pXbnlLcTcrZEg5RXhNbFFLMnp5UXVOT0w3Qlo3OGp5WDdYK3d4TjEx?=
 =?utf-8?B?d3RqREMwRUxFQUZRbytrTWFRR1B6SFlzVzdGaHJybnBKT1RReUpUQUVqWFdu?=
 =?utf-8?B?RmdZdjdmTzloeVZqak01QkNoWHRvVlVHYjV4dmM1aURodlA5MnV2Y2I4RUQr?=
 =?utf-8?B?NmpiTmVUQW5XMkJMYXpyeFJUb0x0OEU2VHpDSEdNYVZHUUMxNzVVZG5BOVZH?=
 =?utf-8?B?RjMwdkJSeXJrM0lTZ2pWbkdXVFV1cm56MjQ3R21Ka3JRNWdHNUZDNjhyWGhw?=
 =?utf-8?B?aExjZ0NrNFAwTGFxVEZvTlpRU0MxOWZnVWhiM2pxdWZYcU82amNJQ1lENExO?=
 =?utf-8?B?NXVDRktVOGFHVUhud2FYb1Uya0liR3dpdGhHUXVIaUl4eE51em1nOTVaMkFl?=
 =?utf-8?B?a3l4UU1MTllUblROV3JIN3JhM1FoNkdJUW9pTzNOVzdoenZhU0FHNm54akht?=
 =?utf-8?B?ZjFkTjl1cVpXRTl1eGxocHJIZ1c1QzBqbzliUm1Qb2srRnFXQzlOWWZBOGJ1?=
 =?utf-8?B?WldYWU5QdjVUdWx2RzlnYUNRUXJZbmpKSGJSb0pSUklzYUx6R0E1bUpIbHpY?=
 =?utf-8?B?dGJPSFlKbzRoMWlyaG1WVkw5N05lNDQ0cnNsZFdwR3krd28xQzlWLzh4RkFD?=
 =?utf-8?B?djBJNHN5Q1RNWnpZZm5USnRaWWVoVkZ4SGtBK254a1RaNjFNN0lPcFNhK3Jm?=
 =?utf-8?B?V01EVXlXcHBzU3pGdUNYanI1eSs0by9OeG5zamVnRXNVZmFDYjArd3E0SWlu?=
 =?utf-8?B?SWlMVGRSN25UUElCcXN4dFhiR1dFeFlFaWdxbm4zTStQT1M4bDJVVmdTdFlq?=
 =?utf-8?Q?YEtNSmBTojHBDYXmf0FrRlSLk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aXZVYWgxZWd4UkJPMTBzdFd6czJwK1NOcnFObVRMY3p3cHVVNStqdkNSMExq?=
 =?utf-8?B?S3RndFRJQmJXMmY2WUlXRzFsNDkzRFBNcHZLeXRIU012YzVjblRZWjROVVRa?=
 =?utf-8?B?eXI4OVlockdoUkEybUtYeHVVRjZpSWpMQVliRW95RHhaRkgyUWo0VXpiM0NK?=
 =?utf-8?B?SVdvZENoZ1h2K1c1WlRGUTZXNkVjREZSRzI5WWtjOEsrR0ZuV1dPZHZibmFM?=
 =?utf-8?B?cE1YR24vdkhXalYvMGsycmpiNDBteTlyb21TbTl0TDdGZG1WNTN4bnVIWWlZ?=
 =?utf-8?B?TnR6ZFB0bUswa0thbnArcS9qdmN1TFBqOFhBb2dZT0J3ZkhnQVIvWExJYkpE?=
 =?utf-8?B?ZjRYbmVGekZCdUF2bjM0UGloTUprYUpuM01ldGQ4UDYvckh5aC82eG5aSzFu?=
 =?utf-8?B?T2grQVhxTWw5NzJyaUJ2eGhPU3Q4MXV6R3F6VkljaW93K2kwNHFzY0wxa1RE?=
 =?utf-8?B?T0lZRmc1WlU4TnVpUUt6VWQ4eTV1M013MGJuL25jdFFsUkhmT3BNSWI4MmVh?=
 =?utf-8?B?OWtuUS9lUmZRVzloSDVFdWVKNVpqTEJmRitWeHhNT2ZlTGR3ejg1NEM5Nlpy?=
 =?utf-8?B?VUg3YWpxSk90OS9qV2daWFI0MXB5OFRKVlNYNjQvY3hKaTJZTTNUeXJwbGd5?=
 =?utf-8?B?cUcrcjdueWxhT1g3UXpNVVFiMHlHWE1XZGx6VzF5M0tOQldvenViNWIrR0Ew?=
 =?utf-8?B?c0VyWEtBR3RGV29KQ20wR3dVVWR0emtSV0xRRVFmYjVNSEVFemxTK2Y5QnBk?=
 =?utf-8?B?NTd0R3d4d0NHd3VQWHp6c3pvZUtGMDRWYWZIUkNMMTQ5UURhQzVaQm5aSUk3?=
 =?utf-8?B?TnlUdVl6ME5aeVBiTFdPbXhETFRvenRTckxPRU5LQWFHLyszRllsOGVGUnZF?=
 =?utf-8?B?Tk5TdE1laDVVUGc3VDJibjBaajlwem53OEhiS2c0dWY1MXRNdmxiWVlrVTJy?=
 =?utf-8?B?Z2phWkV5N1VTb2ZYb2FFWFFOTHFpd01MUCtKYiswZVo5L05iVU9jZTB1RVM2?=
 =?utf-8?B?a1hhMjBBRmpWcVlZY0tma1MzL0tSc0lUdzlpeUNkcHRocnhzcTMwbVNKb2xq?=
 =?utf-8?B?RlJ6Y2JSbGsweWpwUGZXL2dGR0kxME0vdlFzMENIOXQyNWVTS3NSRUpOUGdV?=
 =?utf-8?B?TVVoTWh2WnhVUXpoQUFyVGRJdHdjVjI1K3VTN1JIcUZkZkI5N2owaTZ6anQ5?=
 =?utf-8?B?TW1odlgvLzMrS0xQYURLTzh4T0RYRXhnN2VGbXc1dmdkQXZDYXZIMFZkaG84?=
 =?utf-8?B?L1VlME5XaHNlTGJmTHpCK1ZFTGhXemdUaHBzRDBYZmgvRkQyNHhLaE1GS0pk?=
 =?utf-8?B?S1ozb1grRkZXb01HRnBCZ1k0V3hOa2QwN2Q5QVVXTjlHVjV6ZzBwRjh6STY3?=
 =?utf-8?B?dmliczhXVXB0VXYyTFZYOHEzQ0VrZmJCaFFqaDdkTVF0YUhWQzduNUVlaWQ5?=
 =?utf-8?Q?K67kN54l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fac8100-e134-4401-6218-08dbe4ab7c09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:48:57.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSlXM5ACz78jju7RU7H4Hzv4UGc3fpnjxIcEmq1BDWmK0fUi+9umawQnyNLWmDjN03olwuf6NTKu3ZhVFUreOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140003
X-Proofpoint-GUID: DZRw0Tq3CELCYtDHIkY4iMebobuMT5WE
X-Proofpoint-ORIG-GUID: DZRw0Tq3CELCYtDHIkY4iMebobuMT5WE

Reviewed-by: Anand Jain <anand.jain@oracle.com>

