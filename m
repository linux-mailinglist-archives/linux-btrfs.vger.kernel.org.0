Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A7354ADD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhDFCcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 22:32:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33906 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhDFCcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Apr 2021 22:32:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1362Sjpg056118;
        Tue, 6 Apr 2021 02:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XMGRTFYH+iQqrcYenjPe18Bgg8q30TeXFNwwCuwHZyY=;
 b=zezsyYQFncVATf/l97dawAy2LtfcDgNG5K7HRDXH3edut7HBC/GImgDHqhCSrSKLePpp
 HX5zniwSfTwU2pHZI07DMTBbC0GCUdL1JO/mT86leAHZJrJ/WL7sUogribuLT2CkgK7+
 Tm8Qmj4EGvtGSfv/wI9LiNVREpCqZ6VhV/MDb6PwNRM5NCBFhfXIglkXWhfKzt9bnjMJ
 OM8K6XM8wVHIsur9i9/Hmq3aM7hfJW/yoQc/02wzGHgSpqLfLqwWM/lzIYlbmbLs3yRm
 HJ23JzQZyZQXjKokJM6YtxjdDOubx/OUXAPFDn25B6wu84OZvu3mHx5gO3+JV/dfCDXR 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37q3f2buh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 02:32:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1362Tx6Z172791;
        Tue, 6 Apr 2021 02:32:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 37q2pbxg73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 02:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgcMhrpjKz8tc0DqjV8smWYwt0FuDrqqEaNRSq1rEP+S12JqJ6j7wYeXFGBxD6KdrAQ+c1FaRlT+GRVPvA2ssoxx+sGWgqZpYE2vfW4Am//4C/iTWPsV71QJ959bV4gqVupOyOEFdUMc4D8PU9NkxqSmUzNgXaLrjBusCHvOowE5OP8kc70sNFJ0yCg+CmBpzLS1roHZrzZ7V9kPd6tGj6+aOq7qSsLQMTzA8SFXdba/Lp5Ol7sSQS7g0LHTCrWePddmnR5NlPozF65LIRrULjWCgpEzCItyRe2OpN4JUGtELOLBsWVGlrsQM/wl0bxT1RBvAC2GWaDxI5bPuAX1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMGRTFYH+iQqrcYenjPe18Bgg8q30TeXFNwwCuwHZyY=;
 b=cVjsb4EARnbhPbBsEzRXfD7LVG2HF+LtOSPWhCF79OSzxSsLhLcfbAYoECLGaemfDcWHl6vRHbflnpuYvAAnorLqbEOmRGdhbQFfuk0DH382/rV7MT5HedyEuR8aFN/371mcERm9m+7rnw/1WFxp46RrBejP91SoHk/KwfGHsm89Ix8WYQ08zdkRC5mfeHsRCSsOjW17MKSazKxVIvbPx0ex63BqTJRX9XFvevFqzdclFxltlHrM+6B3yryE85jL/QB7i0TZjsJp9Pi2rleK3lzodyOWaHCE5AtDBCsFE7TnG3ssElNxyTGx/1jL/13D4W3Bz5CbHD69yFZDqr38Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMGRTFYH+iQqrcYenjPe18Bgg8q30TeXFNwwCuwHZyY=;
 b=zXC+UbFhjua9mp1sPb819Zv9pTLCZm5iWDE85i//gytEwI1sXgp/FpuWUMrpYPIW83mxuTKkTB7fhfV0V/INBHvSJQkW81ULQeayTrMOSw2I+m5WZTotpuxszUH7T33XI2fX7NyWRkaWvwfRqybfuqOtg3w1qQ93pZ/fRgYDjao=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 02:32:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Tue, 6 Apr 2021
 02:32:12 +0000
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210403110853.GD7604@twin.jikos.cz>
 <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <10c3098d-94e3-7cdd-030e-bd4ef5061163@oracle.com>
Date:   Tue, 6 Apr 2021 10:31:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:b931:4b44:a245:cfa6]
X-ClientProxiedBy: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b931:4b44:a245:cfa6] (2406:3003:2006:2288:b931:4b44:a245:cfa6) by SG2PR04CA0128.apcprd04.prod.outlook.com (2603:1096:3:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 6 Apr 2021 02:32:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc34de4-7e6a-49bb-b539-08d8f8a42ea2
X-MS-TrafficTypeDiagnostic: MN2PR10MB4239:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42391A0014E167FE7E9B6AA0E5769@MN2PR10MB4239.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueKMz1PBbLFEcpbRP48DAPxLxnvfAkSPLtFC6pUH/BYcOogVbzfV8Qk7M7AgRqTG1G0qOBd4Q2GdXBfysgubtNjGDb858N6jzUVApgUeMEs/yltVYMYY9+5tITJIsdioJu4RJvr6dVi/L+xczpnRcMZ3QRd47Klli9O1x9Vze951C20t7QeUpLoihhhcBTLPHaxBLGLBj4/oTy4RwIxCdNOzgdeGPXe86X41jMnD8yZMIvaf6KPfFEVGnDEgsg6HeAwzTA176j2pra4vOjZ25756mM7h6CT/Xslmhvoeozpj1GrwuL9jlEKX+sQU28Upgpc9XZZ2/yPkyWDxO7PxTnxAwQl8hpVvAzaR6HhOywyTA9mjNCN1sss3GSmpuvgZx/R7x2VNLv8V3ZHq3AdX22SphSNnDq1QcDYCZ+2Qhiwuc1e6BkD9lbt+JQxcFfp1k5Kt5hVMz8YBjyNSjxHUa4WjMNJ2p3XlKnnDguevCRYozyW8ZaAUVnI5J2gmJrgZyUhlIJYzTscXh1OWiEddWK4+10JWpnt2wTG0vMDvPIWfk6QviaRSRAvkjOjqCLuqQrETOMV/TAeoy9dKz0owBT+jH0SGNmrGcpD3wZhDMtjoequTMWEqrtumvA4gjxCexFnjRv1MzoYlrFErlppZ9dmgw6X4/Jdn/xhywykRuBfcTPA3ygtWEGypVyTwc3YfQ/TZ3Tbbdfh8plIuSQXA83nqfHDaIduge7Lh2nC3Mz/hBA1FAoRD/Gd1hAcDUA7KsEsy8pSO1zMNuvOnbBngouwrtSJ0RNk2Ay5r5eriMEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(366004)(346002)(966005)(86362001)(66476007)(31686004)(53546011)(5660300002)(110136005)(478600001)(66946007)(2906002)(31696002)(8936002)(2616005)(38100700001)(6666004)(83380400001)(186003)(66556008)(16526019)(6486002)(316002)(44832011)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGR6OUZxZDFYTlNxbnhKMkhnUmx1cVkvSW1vZGZvZlF5RnBHd25pdUpVY0Zv?=
 =?utf-8?B?KzBLcWIzTUxZZXRsVWM4R05zY25OY0hmUGpJQ2t6SUM0ak44dmIzN1hZdCtG?=
 =?utf-8?B?U2VPbHdmQWJPaFNibnJ2Y05seUc3bTE5cUp4dzl5a2VpanRrWGtwVGplZjB2?=
 =?utf-8?B?SmV3TnhsRDV3aWhBR1BPK05wNnlvZ2gwUjVwWlY4RXZqSFlLbGtOVnhXZkVZ?=
 =?utf-8?B?bHlNeVJsbXErVUxOUlQ4NnpHTHNSSnM5em5VaElQdkpQWkNqVEplM2RjbU5F?=
 =?utf-8?B?WWd5cUk2bE1NZEdlc2dmcXBCWGxabFNRN3RTNk9VakZxQkZaTFBTblFtSUh0?=
 =?utf-8?B?bmdSM1pGTVB4aWFsSW1menZmbVoxWE1idHhGa2Fpb3A1ZlRQMyttdWtVdyti?=
 =?utf-8?B?Vk5Fa1lZMnZIRWZBTlgwSmRGRDhBVm40RzhpcTM5cHJRN2ZqQWNXbUk2Wnh1?=
 =?utf-8?B?UzRlYnNIVXgwckIwemJYQndKSEU2TjFJYS9UUURJdDZSTlBoNUdmdENyV1F1?=
 =?utf-8?B?dUVHQjhWcWZQVStVcytqMk42bnR1YjM3S2ErcTNsbHduWENrU1ZVVnZReGla?=
 =?utf-8?B?RmxkcVVYWFN0ckFiU3RIc2MwZmlRd0R0SnpHOFNabHdVYW0vdEpIVklUYW5C?=
 =?utf-8?B?YjEvMWtubEpvaUNMeFJQR0R2SHB2MlRhNUtqNFRwL0UrUkFHUThCa1JWRTFH?=
 =?utf-8?B?QVQ4WUJhOXMyWm4xUXhyYXVNa2RlWW9ranZzY0Z5bzVCVUpaWmREd3kwUFVi?=
 =?utf-8?B?T1BsZlI5T2E4bkIyQmJLTmtCTlMvcmdCa1UwS3BKblQ2YnZrRzQzQTdXYWhE?=
 =?utf-8?B?WDdyc2J6emZRNW8wTmMwSVJ2NU9EZ1g4U1ovMERIaWV2Z2ZSdzFUYzBsZHUz?=
 =?utf-8?B?b3h5Z3kwMlk5T3lJNFV6MXNJWk13bk8wYlE5Z29VazdiNDJjOURFelI4ZHVX?=
 =?utf-8?B?Si9xVnYySEVTUTBWTjAweWtvMVVjY0J6SHluYzJaa2VTMkl4S3dSbWxGaGVu?=
 =?utf-8?B?enowb0crRXcxbGUwVU1rTUpJM2ZvYncwRWpqY0Z6QTQwRXhIK3ZmdWErbzYw?=
 =?utf-8?B?VlRWb3RQZE1YcDRyOVRlL1IybkVyYzFoN1c0Wkk3bnRCWFhMRFBNR3E4a1Vq?=
 =?utf-8?B?RzhPaCs0TFNzZStmK0l4N3lJMEVSV1hWQ3VQZFJsM3BxZmptb2VHV0lQY1l4?=
 =?utf-8?B?SGZSYzBLd2kxNWRDNG5xSlcxRmYrQ1ZZalAvUlZsZ0ptWjh5MWpBMFlaWHpS?=
 =?utf-8?B?cEhKdDc2SUpnZVdaSTZjdjhlQUhBTFBnc3E2WUUzSmRMS2ZhQ0NLTGVBVVVJ?=
 =?utf-8?B?UG95Rk8wN3VuVkNqMTJycVp5citVUkJDT1NBdk8vclVVRkhGemdRM2NGUTVG?=
 =?utf-8?B?TVpINHNZSWxmUytxR0lPYlJ3TTRjdEs2RitxRGJGYnJSRm5JMDM3MVMzRkNP?=
 =?utf-8?B?RUJGTHhZOTh2RVlvd2EzY01BanE5TUx5NEFyQm16MnU5MUpsK2h0SUpaVUZu?=
 =?utf-8?B?ZjBkMHdKNHBYS21hbG1NK3VHWms1TUZyQVRpNXZkWUliUmluczVQME1sNXly?=
 =?utf-8?B?YzdBWlVqczJqU0V6TFNlaVFkY2dQU216TmFTR0hsemJNRElLQXRzL25xNlVm?=
 =?utf-8?B?djRNZm13OGJVL0h3bHo5N09GbW1abEJBSTJHRTdPb0tkNk95aGtmaTdpRWJB?=
 =?utf-8?B?cS9Jc01GSEI3RU9TVDNCd05ZZDJObU9LVktXaUpXMXo0RE84QUN4TnNkQkth?=
 =?utf-8?B?cVNtS0g2LzEzVGIzYjFDVEFRbk1TTDg3SEFJMktpVVdiaGlTcnF0eFErYVFa?=
 =?utf-8?B?N3NOQ1FxOHJ1MS84UFNQckVmUzluQzlsTDB0RTZPZlY2RTBoK0ptOEVtdTN5?=
 =?utf-8?Q?dJNnPG4PEJtFS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc34de4-7e6a-49bb-b539-08d8f8a42ea2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 02:32:11.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfC7C5cR6n+2EQQNxaoImvagSVNG1pD0ZMJmxkVBirIFBF+vbUsvrE4piNlqLStdPYVwq4p6+ijEH6s3p4tocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060014
X-Proofpoint-GUID: BLNGaYXyk32b-5czM1OkCc3OFVbCfYSe
X-Proofpoint-ORIG-GUID: BLNGaYXyk32b-5czM1OkCc3OFVbCfYSe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104060014
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/04/2021 14:14, Qu Wenruo wrote:
> 
> 
> On 2021/4/3 下午7:08, David Sterba wrote:
>> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
>>> This patchset can be fetched from the following github repo, along with
>>> the full subpage RW support:
>>> https://github.com/adam900710/linux/tree/subpage
>>>
>>> This patchset is for metadata read write support.
>>
>>> Qu Wenruo (13):
>>>    btrfs: add sysfs interface for supported sectorsize
>>>    btrfs: use min() to replace open-code in btrfs_invalidatepage()
>>>    btrfs: remove unnecessary variable shadowing in 
>>> btrfs_invalidatepage()
>>>    btrfs: refactor how we iterate ordered extent in
>>>      btrfs_invalidatepage()
>>>    btrfs: introduce helpers for subpage dirty status
>>>    btrfs: introduce helpers for subpage writeback status
>>>    btrfs: allow btree_set_page_dirty() to do more sanity check on 
>>> subpage
>>>      metadata
>>>    btrfs: support subpage metadata csum calculation at write time
>>>    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>>    btrfs: make the page uptodate assert to be subpage compatible
>>>    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
>>>    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
>>>      compatible
>>>    btrfs: add subpage overview comments
>>
>> Moved from topic branch to misc-next.
>>
> 
> Note sure if it's too late, but I inserted the last comment patch into
> the wrong location.
> 
> In fact, there are 4 more patches to make


> subpage metadata RW really work:

  I took some time to go through these patches, which are lined up for
  integration.

  With this set of patches that are being integrated, we don't yet
  support RW mount of filesystem if PAGESIZE > sectorsize as a whole.
  Subpage metadata RW support, how is it to be used in the production?
  OR How is this supposed to be tested?

  OR should you just cleanup the title as preparatory patches to support
  subpage RW? It is confusing.

Thanks, Anand


> btrfs: make lock_extent_buffer_for_io() to be subpage compatible
> btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
> btrfs: introduce end_bio_subpage_eb_writepage() function
> btrfs: introduce write_one_subpage_eb() function
> 
> Those 4 patches should be before the final comment patch.
> 
> Should I just send the 4 patches in a separate series?
> 
> Sorry for the bad split, it looks like multi-series patches indeed has
> such problem...
> 
> Thanks,
> Qu

