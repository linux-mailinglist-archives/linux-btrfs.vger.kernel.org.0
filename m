Return-Path: <linux-btrfs+bounces-120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1AA7EA9FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 06:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF68E1C20A2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 05:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4EC2C5;
	Tue, 14 Nov 2023 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AXiEz2Zh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pIz3MWvI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE77BE6B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 05:13:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5271BF
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 21:13:55 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE3huEk013461;
	Tue, 14 Nov 2023 05:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hhTsg5H7BFvXUbgCL7GdMu7avBiaNnlPJDYF9zQj6HM=;
 b=AXiEz2Zhyl4Xii2NCHc0JT/Y6hMSwxYn3/DTi2a/cxM3OgZZJX/IPcYvKQPVXwJKh4nN
 svXkVrezkDQn2sTP/fsEw18gCdSYF/IHW2RX9Y+/JVQSBQKpanrmf+IBNYrLPntAkAL/
 Oisvoxn0rqiyDfHAYeq7tsAfpn/xjsN/T7A4f4L3kHFviod9UiDfyOs4GVYa0zh9eaUm
 6ePRaNbnxxfpwgZin2+vTd2WPY/lU3HRgWyMoQfxXV09IePcz583XpfUi2Irw142frmN
 G6h04d8klgl4+fXurdnyvg3VEBuOlZe1eHLJ75sLslnqSzOcPj84TiBgU+HZEUkZHUck yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjmbkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 05:13:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE3osw1013562;
	Tue, 14 Nov 2023 05:13:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj1enhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 05:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBSYoPxHIDeqXRrbJYpSh8B9CZax7lf7Y7FABFpox6vLjNqXs0kUKMaA3bTEJav3OKP7Q1QB/Mv/WUsYHwctTAwF0pGGlBkUzJhAKJ03yu2j6ivQ2JgNE2qVBUofxUbf5l7yoWjq8pewUEj/JLY8/PqTZUegk0UrrIYxpQMn6E2Capgb/J0cg2ylQvd8rbsYelKy4qd6H4Ex8ZnTDExXhK2UM6KsNpWfgbhxhnQNm+SBnstW1ai5H3OaZtW6QiMPIaMAhoj0jebHItJMRQtcMfpZ73QyYKd2lxCv5UgtOoEQTKlAUZvWjD2evwgnO828W8QvU9IeEWB2fXg7X33xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhTsg5H7BFvXUbgCL7GdMu7avBiaNnlPJDYF9zQj6HM=;
 b=LKoH5dQzNCSMXSK/wBlMbdYSjJ1dvArakD4WCT6HtGWGbRVr5vH0sp8YmLHFBhjQ9rpMpvXkzFWQWy2LFjx9lNfjBNMZt9uVJe9uMeaF1FfPgVW3MsALY5tnVYMlMgnsJ/cNpYhVocqnUiG1nIN9j6ZDM0Kp5ITA05Rd8ztI3O5Qx1bT4jgQy7X7nM2YbAo9Kc2vFyLW4ijlUiNfTjEVV+z12gyEqcIjPkLbNlcojl5V3o59Du6Sc4eHAfOvuHIhlXoAs6uvzHyJmWgBpMBkBTAgoZajGDkiIsFGD2KVCd8Dtx+jB0AKtp+Fc0Qnck8jLhuThbRa7gte7J0jAzXBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhTsg5H7BFvXUbgCL7GdMu7avBiaNnlPJDYF9zQj6HM=;
 b=pIz3MWvIjNrpVRhyzy/ZBnaSUyQWIRj9eXfJUNFTCtVRC7VxVlFLpy2oijh0WI0xaE4n1qUN5dkL7t6JV/BUsFchbUc/PK7lu6kcF4IHBbcB1GCkikQYKaeta7Tu/8BiI1zbYP+B1oPsdCV7dsz4WYM5KFfrDe2qHW9mUoDCbww=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 14 Nov
 2023 05:13:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 05:13:48 +0000
Message-ID: <64b1dc37-4286-4e42-8074-0be96315efcf@oracle.com>
Date: Tue, 14 Nov 2023 13:13:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not abort transaction if there is already an
 existing qgroup
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
References: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b305a5b0228b40fc62923b0133957c72468600de.1699649085.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: ba76904f-f518-4a41-4327-08dbe4d07b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LNdyiWRWbEPBhbLdGpbf8P9YQycXZryCCdHqmdtQ3oC+glSfvs9oG4PCEJJJLs3zQengp6LD8uXd17uLSUDmaevAvZRJzpYsjRRyDjroIahRg46B799Tm9rOME6ktl7gRznt1Y8En9b66WaIbv4f9ysbE3UxAV/WROOEmss0qTpHXCq8wc6BGRBq4uq/P7UGDfELXv2HX6wAiGtLUQLX2sJIugs6BWgT5PC779IN5sQwddDWzYREKQ3M5xJP2QHTGfKQxfLwhrEaYezANB6Dt10PCYjiMK0s5ENKJbMS57dAlL1jA4zJ9vaKsBskjerYrSraZUZvBBI60CiqKDTTbVun71NEmRnbhU33P6T6idR5TVpypgqt/DO8mIwDN0vXYX9fFfF7jFVDGqlD08d7LT5QGkaQgnMdzLEn7efBdNgoO6NeOj6S3JOf0h3ZfgdFmgCh7+91PjpnnFuWJkdE2DT+pVyn+KdmaURZJbITzjnV/04JJ7ZAh/f3lWbd6FOstkX8pjqzHrNadv+inSo2nq84t/punxKDNsa8QwaHH4pAGQc6EsUYlWJfmmHQBdsbRajWJIFrTfdfC+D2OTZLSAVoAAivcnW6dt5fMunRXBwdnwlaxLnEVzV0x7WobIwYeAzRkWmWNpERiDAN+hKVww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4326008)(8676002)(8936002)(83380400001)(31686004)(36756003)(31696002)(38100700002)(86362001)(6512007)(2616005)(6506007)(6666004)(66946007)(66556008)(66476007)(316002)(44832011)(2906002)(6486002)(41300700001)(5660300002)(26005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkVKTGRDMTF3bXpyKzc4VEdCb054N0pSWVYzWTd0MmUveHphWXF1YWUwRkJH?=
 =?utf-8?B?M0VmVVcvaG44NlBTVSs4a21tUzUwc2ZpMVQvVlZMdjFicGYraXZUV081YzQ4?=
 =?utf-8?B?ZC9Xa1hyQ1VxdGFpM2pWWTZzNGVpRnVNbUdYWnFScTBxc1FyaUhrRTZyajB1?=
 =?utf-8?B?UXpTaXZnS1dKWEt3U3ZtMWIrVVZ0Y2hmNnd3eEFDK2JmejRDRVplRkRQbHRB?=
 =?utf-8?B?V2h2K25nZFJ5QjJkQXFiUGRpSGh1OG4ycDNvYytPdStXVnlqbXNpcE50WC8w?=
 =?utf-8?B?WUVWeUtQcWlzbi95d1NJazM2QnA5eW9maWVOdGR4T1Ywd3F3TmhRQ3owcjJt?=
 =?utf-8?B?VE5laGNONm4xRXEzdnA1SHpHZS9zdStvSUhxeWh6NlFIZ0s4L0dLNTg2SDhn?=
 =?utf-8?B?SU5hQjh0ZVFJWXhiTDF5Ymt3azFxbnZlUUFUbTM5cDJUVnU1eFZtZWtDNGUw?=
 =?utf-8?B?OUJDeFVneE5Xb2xMVWJpTk1XaW9IU0I4VGk2RUVnQ2FZZ3pmYzFic2ZKUXNJ?=
 =?utf-8?B?bTBCSGZpbndId1ovYTV2cWl2bC9qL0lyRWw3ZEVlaFhYU2Z2NnJkQWhwVHZK?=
 =?utf-8?B?UzlNTEthNm80eFVoZkZqQlhVc1V1dGdhL004UXlYRWxVdXprNDB6SnYxUlRy?=
 =?utf-8?B?bm9WTERjVHdRdHRsRFcvSmh2UFk2c0VWWStEdHR4ZlIwWGhmbWRnMHl2ZkVP?=
 =?utf-8?B?WXNONXNweHE1SFd1QmtSUlh6SDZ1dk5yUEFWblZPOUhJL1RFakdZd1BiVVZR?=
 =?utf-8?B?YzU4NVdzQVZrRzd6UDdPaXVxL0tZQk9CVW1ISHl3SFJBRVZoQW9YQk1zOWdX?=
 =?utf-8?B?U1RCc3dIZ2d4N2pwVzByUkNseDR5b2QxYzUrMjJ1d0ZxWW82SnVEeGlzNTd2?=
 =?utf-8?B?aTlmeVpMam1uRnYvL2diWWIxbHAxMjdXbWhjd2xiaWJTYTBJOVhpaWdOVldy?=
 =?utf-8?B?aXo1MEZSWlNIMHFSMFFFMzJlN3JqditXUHBJOXFpQnNtMnl3TGUvMERGZnVw?=
 =?utf-8?B?ODBGNnZEM2xZRDZ0V1ZGWnZQaTl1MzNiQWpJYmpIeXhDYjk4ZkVLZjQrd3Zl?=
 =?utf-8?B?RmZmdVhpbEhkZHU0d0VFNHJOUWU4TnlZdkRqYzREY0lqV0xRbXY0Y0w1dSta?=
 =?utf-8?B?ejlSNkhvcWQ3WnY3MzMraWxlaVN1dFdsbFJyNXA3V2I1YzVwTUc1bEdxZ3V6?=
 =?utf-8?B?bmhLbmkyRk1zbnFQem43cytNYzU4WU9GVmI0eTdzWWFYbFBmYXlFTXBKT3F6?=
 =?utf-8?B?N1hXUDZXbGlWZjNTVTloa2NBOFUzNkYwYm00QU9qOUpadG9LUmZWdEliQ2xZ?=
 =?utf-8?B?eU5HSVU0bU1IUWMzUldhcTZrMDZjZFdNak5xTERMMnhLdXUwZW1CNzQ5cWJJ?=
 =?utf-8?B?UDVkbTFaSzAram90T1lTVHlJWVo4dEdxeXBtTUxGQmJ0SFZGbkhkbXlLM3dD?=
 =?utf-8?B?NjNtRUh1L2IxZnZSdTEweTFUWUROdERqZWtXZXN1VktHV2I1TU9vR0t3THli?=
 =?utf-8?B?WjBMbVZsSTMvZS9WQ2VBQ09POVc5S0xzbDBRUHNaSE1BUU10TkFrMXoxQnRs?=
 =?utf-8?B?ZS9UcHVQSVBOVVgrQmlwaVkrdmtSUFhtTy9NOGszemp6MEVVZkx2eXBDeEZn?=
 =?utf-8?B?YWFIRk5mVnlWTWpkaVpSOUs5WEZFSC9rS3NRM1E1NU03RmlpelUwaUJCNTlz?=
 =?utf-8?B?YllJK3VIQzU2RGZqa3Q5eHE5UWRobGo3azlNNlZLSm1pNlVaUXFYcFlmWjB5?=
 =?utf-8?B?VmE3TVRRMkNGM2JJR3lNUkRzVElLdXdGemxkbnI2SUF4MW40UURiemhsYjlP?=
 =?utf-8?B?N2JzVHV6MjBadkdWZWgzSHBHTTRQYUN6ejVxUk96Y1Y0RnhuTWlSd052RUps?=
 =?utf-8?B?RTNSRkhsNVZaNlNhVnlOU2xjVHdjZUNrR2xnOXJlU0NoamJBR0xlYWVENjE5?=
 =?utf-8?B?N2FYNm1QcEdoYlY4akErUnBldUg3amJ2V0VlS0NLUnVIRzlWY21PbVVwUUNw?=
 =?utf-8?B?TzN1REVNTHZaemJqY1VGR01LWnMzSG1VTFI2cE5TQWRYaVhmcklBZTNPOUFl?=
 =?utf-8?B?eUpHZitTRjkxRmNxNm1BOHlBZmxRTXBXaDA4NXV4bUN0ZzJhNzFKZHN2K01C?=
 =?utf-8?Q?sC6vBmh6GtocG/Sgu/kvkfiUK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J32mVw0s7NKI701UvPxpH6k+I6ENPP/CcJZSeW1RMG9BieJ4TPVsro0l4SbQftxvUiaWDho+qdaVIeLe5KAKbf3R3Bcg8Gb23vll5Cw1gJ2HyzbKF4fiVdayMu4XP9xZHf+xgQdnWzJ4naVi/xdezImhqPVPmTVS0VgHL5msKhrRPfJa7VIVn/16dOXU9gao0IXNytJ35lgrL+D5qoTUAefSHdFnwoYHLyKlbWnPOUU9Wcq42Dz/dAPSaHiyfeFAK2rUuCzRCzMbkKUu2fHW1nE13BuoCSOemARFCAnRVJOpegRiDiwWYkW0BADkm64ytR1VktSHcBO16WIxCNfFRzqS0mO54gX3wgVSCQg9ZdTGe9seU0KhmPsAYw5Gd3NC5EjQJ02OY1Ee4c2EDzKWC8nV1pb5hqbRpk2tWS856BoOxDBkkws3WQvORaboZEVZUWN6c647uUwRSPsJcIEH/tu/fsh0DG6+75b9b/ycfalltI1AILePoL2liAjcexhPhzRfOFD5djGP94rNc4cNn1oFHzmMX88mEIkIa7WyVtwhW4HJPr+exFwxXsUGqW3r6tCyUH4Bcpi8yOSsfgjDMcffdHfL3yxdFJCOYuM9YwrfFLxsuYZEtnsjgJ5mj9AFAwI52qCOQny7qmtGSiSTNySJKNTRR8pRcykMZ6f2mc037O++gGqhytIgxa9/NRlTln8keBysKw8/bKw5QsfJtuT+/EcG0g5bpminP9kxfq1Rrd1G+jut1UjLa/5/JgBJ89N+h2T712+/5ttYg4itG5KqQStskKyfxMIGIXIz0cv2qffo033xotappGCoy3YWxf1ijO+jDk3GLzSOuYFfhEBkYGzKG3c7fflwC0zN8+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba76904f-f518-4a41-4327-08dbe4d07b9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 05:13:48.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy2mLWPppvU0o/G/XkcnF09giXSzRg/4SaTGg+p3vSG60v6XAVhNUpoJnDAK2J2ZZteOG6ni3ig6rvigPOvx6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140039
X-Proofpoint-GUID: ZNSjg2LAACRear-bXfPAo2c9OTt-XgWO
X-Proofpoint-ORIG-GUID: ZNSjg2LAACRear-bXfPAo2c9OTt-XgWO



> [CAUSE]
> The error number is -EEXIST, which can happen for qgroup if there is
> already an existing qgroup and then we're trying to create a subvolume
> for it.
> 

We were able to create a qgroup for which the snapshot ID did not exist.
Shouldn't that have failed in the first place?

Thanks, Anand

> [FIX]
> In that case, we can continue creating the subvolume, although it may
> lead to qgroup inconsistency, it's not so critical to abort the current
> transaction.
> 
> So in this case, we can just ignore the non-critical errors, mostly -EEXIST
> (there is already a qgroup).
> 
> Reported-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/transaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 9694a3ca1739..7af9665bebae 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1774,7 +1774,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   	btrfs_release_path(path);
>   
>   	ret = btrfs_create_qgroup(trans, objectid);
> -	if (ret) {
> +	if (ret && ret != -EEXIST) {
>   		btrfs_abort_transaction(trans, ret);
>   		goto fail;
>   	}


