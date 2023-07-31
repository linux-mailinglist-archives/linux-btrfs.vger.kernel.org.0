Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C3276A00D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjGaSKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjGaSKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 14:10:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E50E7B
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:10:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VHWaSO008808;
        Mon, 31 Jul 2023 11:10:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=E0fS0hQHhXMT+80hiIOUjafJLCI8VhoPo5WSqeU5VXQ=;
 b=CJG+E54OT/cDbkhLeU1Y7G7N80P6KmbF3Uy1EFObLp31VnSM/SGwLnZtFEBGHd90AAJm
 Zyal0EWVQ6kMIH4fV/SxEoXR/4VAru22GfaxKKa/iXSy+d43QYnDO/RVTd3ydOeO3I55
 4rWN9vBIv2BSOV2QHlPGRJyoIRVg3tme+1yLngmSaSrJ5+cczl5z7K5X2+x+8YIynHgM
 YCQ+SSgidG/z8XQPyi3/+ihTJuL9dPHgxzVCqMl6NQjgw+i3AuJos+pXBbCrYt+DZfAG
 IEk2CQV/LfuGGVkqBARFixP0+SQrDZR7nyzEfvboqN+D9E/OBAj7pYzFypxe1gnGfp4m Zw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s4xtmsy3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay678Ch7qCNrl1n23qqmgCR9ZIVcNTitObiskAxHRAr5bJxZUAkmJ+ei7FnwfYb4smccg0aqoXpTUxD8X+ffyGh/Tt9BlD/r/FBbyZn+RkKxPcjeXPKBCSE98iKWK0t/kEJnd/rDNuCAQr2MWaefuedapGf44knZcvoMTzOzp6Ldb2wPignGVpUZHriTEeMYfwGKJu8oI0mQPJv3YiJgMtk4FsJ72uuwOTZMcdRxFioh6KQcTW5CL90uXWY0wcrPRTVpPzVkLv83MQK4zr/PMQeEti2VVjHowUQbmdk78YIPTrwbFJWH046mt6di6ecXHc91+zYlTdQ9jcFnhjXFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0fS0hQHhXMT+80hiIOUjafJLCI8VhoPo5WSqeU5VXQ=;
 b=k27Z8MbtdBAmtYfgtE5CbNY5BBu0cMHBSmWHG7WVdqKKPm+TMeG8CsZAPXXMMXHT1TARM99246uePeY+S6zGkNKS1gJHMt5liMaghAx2NrRST90gsf/ptclZ2GfOpy6NzDTrUWu6q5AdzDFkQgy/COfNBNcBqA7WV1ZJAEZPv/Kb2eoMTPwlEoMifybyVzTzbcYWEFUsSGvty4Lvhn/b9rliB5CUKQS4XYUvTZSJrcUzBipaGxv+g/d7qugFW4jNxWpDyx26TRevlXE1vC//afpQjlt7FpOsUxM7eMvwy49jlUFNJzUrRz0BXYzGZlXyA2ndQDSbSrtkpjMQAciSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MW4PR15MB4649.namprd15.prod.outlook.com (2603:10b6:303:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 18:10:23 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 18:10:23 +0000
Message-ID: <c059da8d-b5d5-20bd-fadb-c6c241323cc1@meta.com>
Date:   Mon, 31 Jul 2023 14:10:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com
References: <20230730190226.4001117-1-clm@fb.com>
 <e6557f41-9c3c-628a-958d-057582f8cab9@gmx.com>
 <20230731070251.GB31096@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230731070251.GB31096@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::33) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|MW4PR15MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 53406a63-dc60-41c6-23e5-08db91f16893
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53+HqvMu8lIOeap7ajN3h3QfgLL0ERFr9izptGe/wI3WeuSUaxSdYuZIGZYSpzkNcO00PXzQeY6CGWABjcbtRjIhH1dBC8VytKFGxjbi6Qzd1noYgmda0q6hazqfNR9DHdiYK8sjlhROoIxZNHurQUoGnhq1fHzZNmDMl2dhp4Qey3Wj3CEB9XtqhtVok2XK2jZqYFA2Q6QemijzoatmAK67GGiJdPIQ+GSArObiJOCP7FSgFoLpyVu2l/zurhPG71Vl8tlJru1oiKVIZe61J+2eINANt7JFPnme7+PmwY2EZLdQHQEOkbfeyqPqR0HanF+G7dQcHvhvWNOHsn8coJl9tctKpuBE4wpTCt0ITNHCWzmfY85dsgIA3gwyRiwfWuP7Eq/E1zP9FPwc+MQor8O89E1Lk1IWoKCiyepAasm3H0HbKqOI2Q0yrsy7nibYGRPTE8Ib8i7gg9gU06vJGGKA1nQfhUo9fAAq4OvIXHHgEKdwi1h1RnasdMFUOS6NiMMQixM1anjD7qsBQF1n9eE35JRvOxBvYKUICAJ0Ws/vqsUzQrAhbtMqyNRR8ubCBFWWyhK64KeHHnQDQ9QQ7TxQwz0lE+KzDWLtvnaD+NqrC9eX828N+6eAIapv4kM3+VsKqQObV5SUXqPFgFfvFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(66476007)(86362001)(31696002)(8676002)(31686004)(8936002)(316002)(5660300002)(4326008)(41300700001)(66556008)(66946007)(110136005)(478600001)(2906002)(36756003)(6512007)(6486002)(6506007)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVZoeUJ6dGs3R3dPYzJoTDhVNGdDMU1aNUlWUXozNThNdm1jOWxseHBGclg2?=
 =?utf-8?B?L2o4bkpjMCtncG81alh4SEV0SW55eDRGVUJKVGFXa1NaS3ZwZkp5SGJleCtW?=
 =?utf-8?B?UU0wUmpOM1ZqRndvTXJkUmJURThMRWZkbnZ0VjJ2WkxUSXVVVVhXNHh2bkdO?=
 =?utf-8?B?TjFWemVUSVI0Sy9wdStiOFlmWlAwOVlYRmg1YWhwMitENy9aZC8yQ1NudktN?=
 =?utf-8?B?K3ZtcElLUEdFR0RPTVdPZEYwRGdRQ2E3SjVMaVlSOFd2Y0Y0VHhHNFppd2xX?=
 =?utf-8?B?N2RFWlFyY2tXMG9IcDYvNkJqYlg0bE96T0dzdExzRXdFRWFJTlNldCtKMFc4?=
 =?utf-8?B?RTk1UktFclpHajdXb1luMEQyb0dETzlZbzhhT0w0b2d6NG5pNFBQbHZBT3F1?=
 =?utf-8?B?cTNSRFlhbDRyQWY1cUVubFR3ZlVRa0FUZ2FxWkhET2JQNkpSdzAvYVZGQk1a?=
 =?utf-8?B?MktpV3JOVVFDQzEraWVjazVYZWlLci9UVEdUNnhWanNqMWN3VmwxSEc3dGtv?=
 =?utf-8?B?bXRpUE1NSGg4UGRvUUhOcDNEQWhOelRvNG8ycFVkTGFBSEluM25OdWY0amxv?=
 =?utf-8?B?RFYzMzNJS29iek5VcWZoTFpPTGFlR2w2WXJIbzU2ZzFzS21QbDJ0YXMrSGJx?=
 =?utf-8?B?Rk1pM1VZaVM4QWJkTUZyaGtPMXdmSU0yNnBCdFZjOWw2ODVsK2MvanpUTS9w?=
 =?utf-8?B?OVVJUTd3ZXVrL3haMzZQQUcwYnB3d2lHQ2hVam5vb0JGUWhZZDBxejZySk4z?=
 =?utf-8?B?TXNLV0xzN3BZOTNwdERqS2dSMWZ1Y25kOXNyTlRoS1FwT3pqN1VqOHlBZ0ZK?=
 =?utf-8?B?Rmp6M20zazJFNTNONUJKbDFWMlhGeTBGZnN3REkwNFpyQk1iM3ZBS1FtT2E2?=
 =?utf-8?B?S0I5RjRPM1daYWxNYTlaRjR2Yll0WjNDTUZpc0ZQbnlHZVUvWk5QTTNGZ2pF?=
 =?utf-8?B?RzVZYkRJZEVLOHU3NUE0bTJrK2RrNnE3cXN2N09DTzdWWlNvRW9idEQzTEVh?=
 =?utf-8?B?OG04dlZ0TURSaXZyL3ZBM0Mwc3h5NFFmSnF5NFRtRkloUTJ4Z1VJU2grajJs?=
 =?utf-8?B?WnBoVmlsTm1ZbE1maWRLckRDaVc5Y2ZaeDdITDhXaGVQNHJjWDArNjU5NUF6?=
 =?utf-8?B?Zm5pWTZkQy91TDRUSkFNL0VSNzZDMFJzM2kxUWplMXZUMlJHM2grTFhIRzlX?=
 =?utf-8?B?R1FYYXNCRGlrTjBzMHphY2d5UjhXaDFoMG5hLy9uRUpNUFBBWWZESzQ0bTdz?=
 =?utf-8?B?d3dOY2hwdFJBWmxyK0tYTEo3RkxubHkwQkRNQjRwWWZJa3AveGQ5dDUyVldE?=
 =?utf-8?B?dnZwVGgyOGcrQW4wdFVoRW1zaGJ5aHYrMVh0bjA2WlVzeGJQSlJsR0dLMkI1?=
 =?utf-8?B?ZU1aZzBSVG5reEZJeU44WVQ1blRNUXpNWmRiWDBaODB6cjhYUWRYRUVDbnlH?=
 =?utf-8?B?ZzlVZWw2OFNCRmQrMVc4NU9RV2poR1cwYkUrbkFnQ0JuUFhYUy81WE1MUGpU?=
 =?utf-8?B?MncwK1B2R2RRR3hobHZhM2I0dUdJWTFMR0ordFFRSjFJKzhYOVVaeEtCbVM0?=
 =?utf-8?B?U0JrS2RoNHE0MTFheFdBbkNXN0lxVjFzQWdPTnlOeWw4dEZLamRSQjYwMnFF?=
 =?utf-8?B?amVZNHBXelhBaksrM29UcUZWWmg5SlZhRDBZY1BqQWVOT21NbVZ3bnhaL2NR?=
 =?utf-8?B?ellyb0RrSVJXNWVpb1Q0UzcrQW1oaFN1WkFUOGlFTFc5L1JmNElDSmlzUytM?=
 =?utf-8?B?R0J5K0FrVUEwM3RJNFpmZkpkeEx6L2d2aFBTUWtZR0swbDMweGlJbEZkUUxK?=
 =?utf-8?B?ZzZSd2dzNkkyY0RISEtjWWRKRzNGMTJOdWdLODRaWHpjQm0wcXNCY3lLNEg4?=
 =?utf-8?B?azA0UUVUbm9Pek9qbEhucDNnbm45b3lqNlBqVHRZYkVHMSt3NFRkZk5rOXRT?=
 =?utf-8?B?d0pIdGg3ZE9Eb2hDOWJaMnBSTHpmVkxDNUNVZkRXSHVwcWpuWmlsTXpLRWpF?=
 =?utf-8?B?REltTkt6TVVxMjRBak9BaTBiU2dMUlRkRlNHSDBCREhaZ1g3M3ZUTTAvS2Rr?=
 =?utf-8?B?T2I3TkNxSmJnRFRncEVnVFBSSmcwZHA4V2hsVmxzaVloM09aektvbnB5aXY5?=
 =?utf-8?B?RlhFNEcwRGdFdG40MGpzMVArdTZsNVZPSzhRR3k1UVE5UUhYTzh3c2NzRDV0?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53406a63-dc60-41c6-23e5-08db91f16893
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:10:23.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNAUPS2e/gFdqSdyfuEUzXSp9/PSp8l3D1DkLrfjNbuO7VqYigPEfZEO6du2apkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4649
X-Proofpoint-GUID: nBjVq8CiIF9kfFj0f7KgmASoR2wjqhX9
X-Proofpoint-ORIG-GUID: nBjVq8CiIF9kfFj0f7KgmASoR2wjqhX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/31/23 3:02 AM, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 10:27:02AM +0800, Qu Wenruo wrote:
>> Personally speaking, I think we'd better moving the ordered extent based
>> split (only for zoned devices) to btrfs bio layer.
> 
> That goes completely counter the direction I've been working to.  The
> ordered extent is the "container" for writeback, so having a bio
> that spawns them creates all kinds of problems.  Thats's the reason
> why we now have a bbio->ordered pointer now.
> 
>> Another concern is, how we could hit a bio which has a size larger than
>> U32_MAX?
>>
>> The bio->bi_iter.size is only unsigned int, it should never exceed U32_MAX.
>>
>> It would help a lot if you can provide a backtrace of such unaligned bio.
> 
> That's indeed a bit weird.
> 

bio_full() is using a slightly different test:

        if (bio->bi_iter.bi_size > UINT_MAX - len)
                return true;

We're doing:

                /* Cap to the current ordered extent boundary if there is one. */
                if (len > bio_ctrl->len_to_oe_boundary) {
                        ASSERT(bio_ctrl->compress_type == BTRFS_COMPRESS_NONE);
                        ASSERT(is_data_inode(&inode->vfs_inode));
                        len = bio_ctrl->len_to_oe_boundary;
                }

The end result of this is that when we get to a 
bio sized U32_MAX - PAGE_SIZE, both our len_to_oe_boundary and the
bio_add_page() check will correctly decide we can only fit 4095 bytes.

The difference is bio_add_page() would just say no triggering bio
submission.  But submit_extent_page()'s check is first, cutting the
IO down to 4095 bytes instead.

(I do have the stack trace, it's just a boring filemap_fdata_write_and_wait() path off of file release)

-chris

