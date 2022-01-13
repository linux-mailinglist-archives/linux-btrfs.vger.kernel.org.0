Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBC248DC48
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 17:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiAMQ5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 11:57:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231269AbiAMQ5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 11:57:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20D8KALU028979;
        Thu, 13 Jan 2022 08:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QpHQlCwBZ2cY/KDO0focrgtQ4gHsXy/HRYR21MpkN54=;
 b=Ri4SC/S8pvFGSjxpmQUGhr7/doQrFDaj1Ons3nGbw5ey8C7CN81Oo52nDUokeaMIqhs/
 JWG2hI/GS70Wwf9FG3OEZN6Sk444eoHhbUUspLxPaWTug5AWr+LGm/EBbinXvp3gSIue
 uAxhQleoL8ypcBA5WoQMRQcpeegAmE/jzeQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djgfktqw4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 13 Jan 2022 08:57:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 08:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iay1EP4jB91qOCpRMC24M0qsgPpio7T/IsCTDrOFeeoHuFsPOPCKIXoerAwxtV53OyCwsJt1zn1Kw2qo8iRJVT/4w/tsOfItrl39gXR8MCuKIyEEkMo3jH/+TQ8dSVhKHPcDjZfHtebzeHyjfWG1139uW2CktauoLAHE1QrSbzxcbuoRi+oUkQv+n4MxCbbWATZmU0z/MwwMOyAAfR0ytILToobub12MTPvmilmr8dg5+oauZZlrxr8j072BN7rmC5hVAWyHbNt6/7BONfVaVzUlvLW76OKOwLBr7tWNs/SShcnXWOiRnwpdvXeVjfiR/7nDVJoFBbi7oHMascYOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpHQlCwBZ2cY/KDO0focrgtQ4gHsXy/HRYR21MpkN54=;
 b=ZxZlMP1XxSN9t1b0U+oETZWAKRMASeBtxcscp3uO6OjzkF90mKfD9jt1L7l7B3iJPntCflq0WbJ5Zf9zBCxvGNp7PmSVBjFHH/UzNrkPxkYeZ5dkVIk0ANkSHC7snBer5brkGni7pMceDCe7E72xAyaVzkCyUYzFncfsTkMcdjHejicE/4SvtUSus5SwuqN03cXGj/lQyLK/w8LyhaDV8e8FvUf/jYXh+C0m8MqjfV9zw2vHpaP22YfF0oIV0TXKDClgHLQJMYe3od+1wjHR+KiJ6HTjnaBB1fVTNkBmidHMDLr4IuSw6bn5XZzous92m0lo91mw8HeMRG2ZVVQqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by DM6PR15MB3973.namprd15.prod.outlook.com (2603:10b6:5:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 16:57:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 16:57:23 +0000
Date:   Thu, 13 Jan 2022 08:57:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <clm@fb.com>
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Message-ID: <YeBZ7qNjPsonEYZz@carbon.dhcp.thefacebook.com>
References: <878rx6bia5.mognet@arm.com>
 <87wnklaoa8.mognet@arm.com>
 <YappSLDS2EvRJmr9@localhost.localdomain>
 <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com>
 <YbJWBGaGAW/MenOn@localhost.localdomain>
 <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info>
 <87tuf07hdk.mognet@arm.com>
 <YdMhQRq1K8tW+S05@localhost.localdomain>
 <87k0f37fl6.mognet@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0f37fl6.mognet@arm.com>
X-ClientProxiedBy: MWHPR1401CA0024.namprd14.prod.outlook.com
 (2603:10b6:301:4b::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6aa8f54-a7f6-407a-c677-08d9d6b5c4fe
X-MS-TrafficTypeDiagnostic: DM6PR15MB3973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB397391EEFF9DD503C8B217B7BE539@DM6PR15MB3973.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XllC66xeZje7SvEBmSNT33B2ciJmm+CO5qlhRA2v7D4E0gh4y9IqG5gwHTuXPS0PizY9aNULO70wdZuRu5o1IMQ8g9T0X81dpBS8hKdQk+GiBxYXKRTrtBafC+p/hKRVhT+Qh5RNeUfE0MjaWgEJmQus6yUP0QpK/8hoUcuH9qepIhDoq3QTIfuZwi13YArI/XVkxItw310xYUGmr1ihZlEAPhgPq1IwEiSH2A3FcqpaTenSEd+tLlC5SLrP0VcBTVaduMY4+hNco8KiniFU4iB0fI0D4ZoesPjVVNWmCyaOXD4jJgA7i3gkf36XmljG1SkmoHYeLr3WxKljPSUP3jzRQpAW+WxGVqdgqBgqTVVKZPVOCt9cRyoGA6QJE8Laq4cw/GuF+ruvwHx6IrE1CTIZL/4vL6U+j0/REjPQkVMv1222pgwt6nkQMU+ke4gP+7ySHv0OWlSLdoS5n8jtATDOfdbJpMgIPBXjgJtdNA4n9edRWD7bAZ1IMEDR+qdKVEx1WCcpKmapyGSTkV9tbt0MxSkcHjIJEIgcVzANELARCiqK/DCvdIQLJqKz673anOMJj+hc9lP4SyBMdREf1JFzXqXjhXdPXgxyNyMVT6grWYgKQVhXN+8wMqP6ohkxeosLZG/udGUgLdny3FWhAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6486002)(86362001)(9686003)(66946007)(6506007)(38100700002)(53546011)(66476007)(6666004)(52116002)(5660300002)(8676002)(6916009)(83380400001)(316002)(4326008)(66556008)(2906002)(186003)(54906003)(508600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8BmnLVw3UiBa4RuxhOw6FnofV4ira1LyR/rBzdDnMzIwIgwHksrdU1q89dER?=
 =?us-ascii?Q?/LOZVgkzYtO9J3Fbyq1LxKeJudgjNps/1zHWe+yEHMDOJKbcfTgDjtccGomY?=
 =?us-ascii?Q?WjXd+hA+gzj+yP/3th8bKOhDT859QZSgv8id4KXzA0bgOxTJIaPhYw3eQuNl?=
 =?us-ascii?Q?ivz3ThSTA/wUc2mLohpdx9JdYdc3ZEOL7CglTijo+uVPdqyXW1CsapWLHBen?=
 =?us-ascii?Q?re7pc1GuUco33+tMYl+QxZ1fm8EEd0bppDaCBua6YTfhiD1UIZQUajhxo1J4?=
 =?us-ascii?Q?X4aWAaTd8Ok58C5bhWF7MvJ8YfBIKMYa5U8P5N2nsO/5gftMNFaWsYRH0nsH?=
 =?us-ascii?Q?tVYFqXMBvCHeiJ9iF7fVTWX472Wd6n/egwYtBPGcuIJEB+XqDs+PIf6eso9V?=
 =?us-ascii?Q?Cg8ynOvQkx9pIlw0VUvyKIAc0Gn+N/NqOT5670Z0RvDoqnOIaFeGmKiaIzVE?=
 =?us-ascii?Q?8Qt7d3z6kFFlKKxQq+T7pdYdjFMUP4sBmpb2KAhnlpd2LfsJTLYWpPAhk+bw?=
 =?us-ascii?Q?0R4vjphe50LEIcjDkInG01A6rUpNtviWHqbXjl2bYnylqPJoI3pirICuiVYc?=
 =?us-ascii?Q?BDS1W2RTB9bK47R6a7cQm5smfo2lzymLGVwcx7jwtmqCXemUKIXD1vjJnaME?=
 =?us-ascii?Q?xqXaJErOc0qBWl6nRyaGoSKmQMy1RNP40GLatnKSKEHY7OJNElW5oL7elHPU?=
 =?us-ascii?Q?htXOncQLrO3ucM9FV51x9lr5Ql8Jtrs5akOAFgOX+aKCxrAL7M008YjH825r?=
 =?us-ascii?Q?VJB+8d0KmF1/ZUv1qU+v+5cCktdfcueTV9f+EkGgHPPuFnWkd53b06EpRNQQ?=
 =?us-ascii?Q?dIku1s3SGS43Bhof6o5UFAkGX4/rGqhMUE9N3WRBkPM2BdvdrbKy7ge8/969?=
 =?us-ascii?Q?JAbLLT61TKoge9M5bwPf1CzwhsO5RO6F51owv5yertlRIM53hky5oNRZ1taE?=
 =?us-ascii?Q?QvPqW8AxLHqr9HjJIT4fRmqUDu1P8b4xjaoaCuvphKJ25F9nhvopZCVkHvZa?=
 =?us-ascii?Q?NzQ+h8RJ0sf4jeVLeW3ALMKWKzBtQd8S5TfxtZ1E7+uO/wQXOgelxHlOARLG?=
 =?us-ascii?Q?IC0VxM700zqdx2TGnSgwfhE4NfwJ575OUDeyOCYXvGVCkHFsOqG7JdCuPpgD?=
 =?us-ascii?Q?QpuKRpTFVg9ehSVUGib50dYpR5elfuMk+yfg7bJ7v3uoPgqg5a3zqGIMAzcx?=
 =?us-ascii?Q?vt26rC6Cq6ARM/u0CmaMc3DzR4HFsJlgXlDnBzDoL1pSn4la/agrXKL8EfEn?=
 =?us-ascii?Q?i65KubFhip02QwrA16LyoRAnLjESasVEDpVKO8nVaOyJZILnMphj2F4tS0sc?=
 =?us-ascii?Q?Khk6N6IOOq1eS/UdC/p4BAnlLdhO9h1NRxEj7kJyKY9tkrYtwllMYBXwF6ou?=
 =?us-ascii?Q?byNVkO8t9jggWAhTFNnJWnHR9HV5pxdyE8KstvPOy/qSWdc+Z+cZVsZsJc64?=
 =?us-ascii?Q?TGNVeyjGOOgpfX4dLqXsza6Kq8A396rn4Ko5iO85v66tcRE1vJrLZ8R7VaIs?=
 =?us-ascii?Q?KPBJqu1eEIGDxaxnFA6mYpE5TsfyiavDUyrw/43xVmTXsHoLKVr5aXPF3lWt?=
 =?us-ascii?Q?3ZanhbJkLo7GBgbXd28enFwMGqMDF784jqcSI2MR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aa8f54-a7f6-407a-c677-08d9d6b5c4fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:57:23.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUGjYWqa1iRG5eBPwdgFRKD/pY6+bCW4vhlYb4O/GyIKXJv0IMJtLlFEQEacKy31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3973
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: BYX-SFlnOzPv1wOvEc1hXiWw7ZaupzFG
X-Proofpoint-GUID: BYX-SFlnOzPv1wOvEc1hXiWw7ZaupzFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_08,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 04:41:57PM +0000, Valentin Schneider wrote:
> On 03/01/22 11:16, Josef Bacik wrote:
> > On Wed, Dec 22, 2021 at 04:07:35PM +0000, Valentin Schneider wrote:
> >> 
> >> Hi,
> >> 
> >> On 22/12/21 13:42, Thorsten Leemhuis wrote:
> >> > What's the status here? Just wondering, because there hasn't been any
> >> > activity in this thread since 11 days and the festive season is upon us.
> >> >
> >> > Was the discussion moved elsewhere? Or is this still a mystery? And if
> >> > it is: how bad is it, does it need to be fixed before Linus releases 5.16?
> >> >
> >> 
> >> I got to the end of bisect #3 yesterday, the incriminated commit doesn't
> >> seem to make much sense but I've just re-tested it and there is a clear
> >> regression between that commit and its parent (unlike bisect #1 and #2):
> >> 
> >> 2127d22509aec3a83dffb2a3c736df7ba747a7ce mm, slub: fix two bugs in slab_debug_trace_open()
> >> write_clat_ns_p99     195395.92     199638.20      4797.01    2.17%
> >> write_iops             17305.79      17188.24       250.66   -0.68%
> >> 
> >> write_clat_ns_p99     195543.84     199996.70      5122.88    2.28%
> >> write_iops             17300.61      17241.86       251.56   -0.34%
> >> 
> >> write_clat_ns_p99     195543.84     200724.48      5122.88    2.65%
> >> write_iops             17300.61      17246.63       251.56   -0.31%
> >> 
> >> write_clat_ns_p99     195543.84     200445.41      5122.88    2.51%
> >> write_iops             17300.61      17215.47       251.56   -0.49%
> >> 
> >> 6d2aec9e123bb9c49cb5c7fc654f25f81e688e8c mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind() 
> >> write_clat_ns_p99     195395.92     197942.30      4797.01    1.30%
> >> write_iops             17305.79      17246.56       250.66   -0.34%
> >> 
> >> write_clat_ns_p99     195543.84     196183.92      5122.88    0.33%
> >> write_iops             17300.61      17310.33       251.56    0.06%
> >> 
> >> write_clat_ns_p99     195543.84     196990.71      5122.88    0.74%
> >> write_iops             17300.61      17346.32       251.56    0.26%
> >> 
> >> write_clat_ns_p99     195543.84     196362.24      5122.88    0.42%
> >> write_iops             17300.61      17315.71       251.56    0.09%
> >> 
> >> It's pure debug stuff and AFAICT is a correct fix...
> >> @Josef, could you test that on your side?
> >
> > Sorry, holidays and all that.  I see 0 difference between the two commits, and
> > no regression from baseline.  It'll take me a few days to recover from the
> > holidays, but I'll put some more effort into actively debugging wtf is going on
> > here on my side since we're all having trouble pinning down what's going
> > on.
> 
> Humph, that's unfortunate... I just came back from my holidays, so I'll be
> untangling my inbox for the next few days. Do keep us posted!

I'm trying to bisect it independently and make sense of it too, thanks to Josef
for providing me a test setup. From the very first data I've got yesterday,
the only thing I can say the data is very noisy and I'm not totally convinced
that the regression is coming from the patch which was blamed initially.

I hope to make more progress today/tomorrow, will keep you updated.

Thanks!
