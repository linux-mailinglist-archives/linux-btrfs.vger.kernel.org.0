Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B56D7C25
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjDEMCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjDEMCU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 08:02:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D05277
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 05:02:18 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334LsGIM021304;
        Wed, 5 Apr 2023 05:01:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=lPA1Csq/iznJx0IqaG5jKkOVm10BlCfg5j8ZErExrwU=;
 b=gHwTQ0hfxuX1q2flaI04OVFdyuJk+mhNGudwmL67gQfclZKw6+1IDmy1Mq4hcMiu7/ct
 3j1UgIUbdO9PCPvDIfvOBnVvN0IXhLffSV6LhQ1y+vH4OENolSm7EOAk7AMvhDxjPKE3
 m4+1O1gtRC/J/ueMYWcjSfdJUfYoAjaQGGjuo6x7ZfcgZ4BVX/ahKSA5bFYLsr7T5Cof
 NQozOEbgnlPsMwty4K4Z2HxFWIgSQQe6RYS28voeBX+qtKsprBxqbebthcVypHLekZ8p
 avgqzxBucrAZqZF2KW5c/oTRUi0R2fF/Ksopq/PA6S6LI9eVOOvB8XVYMtMv8vAxvBKf qg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3prbpwhwuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 05:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPx3yk+wbVdC45IrqdDGneoXSK9fGqx80YKOk/cEhgLqWYp++Bbmez74Qv2rIcmuKQnm4sQCtES0GPRYRY15c3bmc65GesMrsmFzpCDKWTeUcOb9eERnlzxxvUPOtj3D0pHHg4xtf59VTOnDtBSYYpow5ow20wRI9YMzA5b6jPLMD9011QRGiJellH9qGhLIDgO7M+dO9Uo5sw657SFOr6FGhHI+q5nKNZ2mAMCOw6ReiIvc2k/bb1C90b9Z7cj44C+Jo/Q7S0XE9rIMP2/ZPd3HiJWIzG+6T9VfBVH4xPIHrWvaJD3hZfGlzS0YEsCsCpOBtff4AsOB1lUZduWYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPA1Csq/iznJx0IqaG5jKkOVm10BlCfg5j8ZErExrwU=;
 b=Cx6DtRTouqHr8oUt57X/mmAgh7nHjWzS5PBjBY8gwFEKTLHgcFedvehrD7c6NjWhnUhm4qXjB4MGZg3QhTkT9LTN+PQteFKHCZy/UXuhH7+4y8LDcolXSE//8sZ51g1zGmxF5xdavTVcr24QnJqwkfbGKmgyGMhNIG+fwQqKwb8zLZ25Nbo0V4/4s2o8GkZaKZNdq06eBfcC/1op47wuFTOZrFGwYpuFl7WVNp5wkNln6OZ/QrJVm7dsMyGC+POYMMQZLJbeLBew15s5RH9yawmqWj5DiGS6ZYmVF3FEapafY0lVTKBZH6SolVQgUznbQqv4XliT0khLV8jvY/NQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DS0PR15MB5748.namprd15.prod.outlook.com (2603:10b6:8:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Wed, 5 Apr
 2023 12:01:56 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 12:01:56 +0000
Message-ID: <da8e4122-9e6a-fe4a-d064-30577a03ec00@meta.com>
Date:   Wed, 5 Apr 2023 08:01:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
 <ZC0SyJbFJuS2ZEOY@infradead.org>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <ZC0SyJbFJuS2ZEOY@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DS0PR15MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9695cded-49a0-4258-6eea-08db35cd8d77
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWX8rCqwtatsaqr06whjav/PgGHuQPW3IxroTYMdwpWuq9srY276EmPN8IhYs4s7knAykqAuy6uzIt5M2a3ark/9kl4BZ1QNFx+bTsJYthCb251iOijnSL34mZOg9IEH8s/RjzC3RBu0cr9NxlNadnOWUzLqfa3FrfmCBwILuP5sTBnr5AfZEmZzKX5au4V/N5R6zdehfYHTuEjZf17+agmRzW8E7Lw8hQ6KV+NCwmYnrdND84sZVgn+FLZ8ncHdh2xeVgRRaX2/hdLFdy7m9MwGQKNNDtpQW9aAnzWhhjqwM8ygi0Z7neEoqKxtl9BWysLSpVowWeW8piZ6GXH6SspGkipAz5jgLEUqeITp1GHtoNDnjdW9xAEJKvBQx36QDt2xhJjRC10ZBi6om8O4QnKh9cxtwjFaUTMrvjbbRCzMdKgaDEmL05gcETheurGOvZyO2uVrt4fq3ft6cui8W4LDbO8t/DWNEZYu3j968h/e5tR/Ctn9+UM7OCqvkw40EhB/g3D0GTQofb4OvMbq+s+WI0qymj2Lc4/0ac6Kcu1CdEgl/+uS5Q4eNfMJGXGu1UeszEmgp20S39eEfYIqdclFMDZ2W3cOUUBxVoO0nTn80VU6TnivS8FwBfU3/aAyqinMVADvLhIz2ppsFWISWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(6512007)(4326008)(478600001)(66946007)(66476007)(6916009)(316002)(54906003)(8936002)(8676002)(38100700002)(41300700001)(5660300002)(66556008)(186003)(2616005)(53546011)(6486002)(6506007)(83380400001)(26005)(6666004)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JsZENLaUQ0ckNQV29WNnpTcXptUm5oLzBYSEtuRjF2bE84Y0NFYmxiVnU5?=
 =?utf-8?B?VUE4aER6WDJwUU9aZFlUdnNYVUVHb2Nra21lbTZlR2NLYzNvZ256OFI5ME1V?=
 =?utf-8?B?WFBTZW1GZ0hDTDZqdnNwajJpNjQvZnFNL3c1bkEydk1ST2JlbUpXVXZHWm53?=
 =?utf-8?B?MTdyVXUwS29yU1lZQUJVVk1tSUdvaHhsbDhnRDM3YjdJNmp1cTN1SVBCWDIy?=
 =?utf-8?B?ZFAyV3M5QlJqU29EaDJCdXd2ZFBLbUU2U1l6V3RYMktoaEhNeTZPUU9qSWtt?=
 =?utf-8?B?cTVDSmNNSmJQWStuUnFVUjVjSW1KYU1SS3FWMWZFRk9zWlJUSXNWcFEwWG1F?=
 =?utf-8?B?TzRqWlY5dlR2aXpHVXZvVFdLdkdTUldBR2FKaDBBNG5rMm1nWXRraWtvbDBV?=
 =?utf-8?B?M1VEWEZ6L1FyMVJwOXlSc05kdS9CNU53TkM4WlVuRnhtL2IwaVlRdmlLZ21W?=
 =?utf-8?B?WkVXM29zNnlHaDY0Y0lveElaclNnTkdpQXhEZlZVMGFUQkN4ckhzeWozbFMr?=
 =?utf-8?B?QnJqVkNKaWttSVZ4MEIvQlZIOGE5c0xXZU5QeWl1aUptWWQ1a3VFTnhOMXdD?=
 =?utf-8?B?a2Z4Zko4UG1oaldIampmaTVaemNjdjdRbmpoVDZFWmF0cGU1NDdORnRTTm85?=
 =?utf-8?B?RDRwelV6R2R5bHhPT3hBTjZqSmd4MTg5bjlJd2JRM3YwQ0lkQ3JDRmNxaE5F?=
 =?utf-8?B?Zm8yT3dWSGVObEwrK1E4N3Vuc25Ib0cxaVlpek1VRmNZZGM1bFlVQUZaTzNP?=
 =?utf-8?B?eE8zUjVnU2xxVkRlVnU5Y1pxSW1JNEY3WFF2bVJ3dUx0ZEJreG9HbGVqdnVx?=
 =?utf-8?B?TWl6dW5SSXVkZDdPNjROdWlIeTdDL2hidU93eHNnVW1RRWd0VVdVQ040TnhF?=
 =?utf-8?B?V2t4amREVmszU2VEaHB5M1NVS1NNSXV2YXd4TTN0enZYK1BiKzRkM2l3NnpF?=
 =?utf-8?B?SUxUTkF5NXdtTElYWmZ5KzFHdWU1SXo3NzhvVWVQTVFxM3BlNzdmZ0Z6YXNq?=
 =?utf-8?B?SVNDUUZBZmQvbXNwdEdFR2dsTXhGMXBMbjFGeGcwSTJjY3BTbHpKZDFhSlFI?=
 =?utf-8?B?czF5b004TkxxU2h2RnJYQzNMUGhFYVEzMmFhRGsrMWtQM2lWN3VIZDdQRExJ?=
 =?utf-8?B?UjVadkhIY1RFZzZFUXRZMnBaV0s0cS80UkV1dGs1N1N1OExFcTZCVWtablJ6?=
 =?utf-8?B?bGRIWlUwalV5aG5DQkE3SzRvTk9tUUp4WisxUmdCZ2hCclpYeDlHMFliTTFr?=
 =?utf-8?B?dnhhaEc3VU91ZU9taVBEZ0VHbkJCZ3JyZEdGSkNWK3oyTEtUelVaamYySHo3?=
 =?utf-8?B?RDZJRFluY0lpNUF5Mm9abWNMT2dNRFE1WUZJeU0zTFdzb094TzJwM0xuMktO?=
 =?utf-8?B?MTFaWVZLckI1N25JUk1FL2Q3dXBHUWIzMEdkQ3d4aURFRzg1QmxPRXB2cDd2?=
 =?utf-8?B?T2EzR2hncWNYZ2ZmQjFsQTBkNWtES2RMUXFNUjQ0RjhGUEFrRTk3Rk5rVjZQ?=
 =?utf-8?B?cFh2RE8vSjdoTmdIajV5VHl4dVE2bDdUQzB0d2tHeCtIQlVrS1lmcjNkRlBM?=
 =?utf-8?B?RzFFN29DWThTWnNMSWNGU1k4dmtIU0lsTTBwWEFXdzJ6VUk3dEFmTVpQU2xC?=
 =?utf-8?B?OXF3Y3pieTZ0eFRmeVZKNXBZZWtuNTVsblkwWE1qbUJ0cmNURURGTFNtVXFP?=
 =?utf-8?B?d0JXYzdjMzhVVThlNEI0bzFGa3JlTFlUZ0dPOFZENTladjBhdWdDWDJBTldK?=
 =?utf-8?B?QkVsMEVxTU4vRUlmb2ZURWNHb3o4aVdtNFlkek0xcFRPOHRJblFlYk83aDY1?=
 =?utf-8?B?QkZqWE5yaE5ZWklQWDN1Q1h0NU81dTZHWXdweUp1OVE2MkNFbnU3bzBlT2gx?=
 =?utf-8?B?ejRncUYxVWVKRjBZNHlEZDFjTWxJSVJkQldwSUR1OGRjZXRmSUdIZTZZVW1G?=
 =?utf-8?B?eFB6VzA1TFRIb3h4M1BHVlNzQzRtbitNVGo4R2VLMkZ6aUo5TDdsYmJzMHJk?=
 =?utf-8?B?Wm02cnd0NWloVjVPMkJwMXI2WlUxYThGZUFodjV5V2R4djZneTRnTUY4Vk1y?=
 =?utf-8?B?RFBVSHlyWHBvbUdUNmZPQnhKcHpBOUlsVzRvRkUyYThRZlFyWmR2V2JNbGJI?=
 =?utf-8?Q?tbKM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9695cded-49a0-4258-6eea-08db35cd8d77
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 12:01:56.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpsI8TmqRmtKum/PrXILrODH7PpjBf/t1PiNgbQo0jqe0XK8ipzrARY0i1ZFJmYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5748
X-Proofpoint-ORIG-GUID: cDCd3UatLzd_8AovrsFiWAX7fPPHKzG7
X-Proofpoint-GUID: cDCd3UatLzd_8AovrsFiWAX7fPPHKzG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/5/23 2:18 AM, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
>> It seems like a good time to talk through a variations of discard usage
>> in fb data centers.  We run a pretty wide variety of hardware from
>> consumer grade ssds to enterprise ssds, and we've run these on
>> ext4/btrfs/xfs.
> 
> Remember what you guys call consumer grade is the top of the shelve
> consumer grade SSDs, or in fact low-end enterprise ones that are based
> on the latest and greatest top shelve SSDs with firmware specifically
> tweaked for you.  That is a whole differnet level from random crappy
> no-name SSD from 5 years ago.
> 

This is definitely true, our providers are reliable and support the
products well.  But, you also have to factor in the write cycles, drive
lifetimes, and just the constant threat of statistics at scale.  Drives
might come in off something close to the top shelf, but datacenters are
pretty hard on storage.

Going back to the fedora thread, we've definitely had ssds with
reliability issues caused by trims, but we haven't had any I can think
of where mount -o discard was fundamentally less reliable than periodic
full device trimming.

-chris

