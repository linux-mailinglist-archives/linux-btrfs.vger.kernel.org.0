Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC1464A39
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347976AbhLAJBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 04:01:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20340 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242281AbhLAJBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Dec 2021 04:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1638349067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udOFQyUmp0QEz+tXB1zYnBDLM74Rh6PpMlbBHF3JqPY=;
        b=bG4Gzryh8AM1AI8E7xKe0z4/Jr5ULRVbnOD8J9BLJCNKnEoOoqBQ9X2rctLWazMP6rmvFa
        G7vPDkdzdXWGYzY+uOVzA74YqfseB3rjluj6CaCLphdVExjiPgrXnJzTt80n4VRIV/oCb2
        gwPDGF4l3P8BVJsdV4ug2a/PXSU91O0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-1-IgA7gTcINO63VQiGbzs3-A-1; Wed, 01 Dec 2021 09:57:46 +0100
X-MC-Unique: IgA7gTcINO63VQiGbzs3-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eabyv1YqteqOBLd8wBrxwl5Kyq8Pl8K/SoNbGSBRXUGo5AKWykUdMts/22Dntjkm4jM6O3fTe6s+Px5IK1KxBjhzXRFiwAwJOHopMQ4XkRr5IhcykO1lzMwvUwTXI0d9X/cN5uKDZZrQiRCyQ9KPtm5pHz/ysHTTldUY+T+/aLBbLEsPtYMmh4F8oqdEgsFY3ubnZdwwT55tNqH/VOV819zlKizUK59bvmqiLzT5bKT5FKBVGPaBNexziUKZhuCX2UNJlRpwW2uZEYSPtEvpw0XFJc+H/uPKqUuRlvqw5//FpmV2byb7PdiNwK5RwURx/mlLZkybCNatZWd8fpsmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udOFQyUmp0QEz+tXB1zYnBDLM74Rh6PpMlbBHF3JqPY=;
 b=NHHBoYEvUaHM37hfBUNHDo24dnkonxwZPFNn54KC7NVbNl3e5YWekQulvT4oVFZHptuEiGVCW1A3RiGkmZxR5yOORCUWmXcKuuzbTR1kdeJRH741tN3xogSk6u3lyItcGSsVYGCtH3zVwcLsDJRgDLaY//O3va2PazSFn0tAZ0JrjKZFte0sDRbohhBwgw3mREHuTSlhO3KUoU6xEYfPWyoKmmD7tF/e/aispotlYXI19OnmYmhsFVCmJlmamtpTK2Gswiecj7+pcO/S7RKmi3vtDrq6igwxtuHVgftOnSXV6WbO62kngpuRfdikQaIGgrwThQo3VGwXEQ267OAzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 08:57:45 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4734.023; Wed, 1 Dec 2021
 08:57:44 +0000
Message-ID: <bf794c47-35aa-7823-35ea-854873a20949@suse.com>
Date:   Wed, 1 Dec 2021 16:57:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 00/17] btrfs: split bio at btrfs_map_bio() time
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20211201051756.53742-1-wqu@suse.com>
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 08:57:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df69c5fe-84cc-456f-8503-08d9b4a8a3e3
X-MS-TrafficTypeDiagnostic: DU2PR04MB8887:
X-Microsoft-Antispam-PRVS: <DU2PR04MB888743A17C3EF5551BB60A23D6689@DU2PR04MB8887.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XafGkp3xgCi/iCrSLJ4ROZ+oSnj5X5IkV5zj+C2KYf06xDAGgKA6LRc2nzYV9OMzFISkhgXTgFb3uNRKh/aNW8jwYfh8Ve5bayBxjeL8ofXI69FdrqBAebHiCbrSwMiYzdNbzxj8XKKNVrVaWSRkXJJz0vSfMamQLFNUnMwV61zNZWlhADANbpL9RPJkqRyJDFnRsPgw75OijGRbTRQdGuN/18z4wk4kq3D7rA3b3Zql/csmWL02hvG9lQt9E/prT7D5IAWJ+rkKx98VWdlTc3IoYwOTblxjBJ+OQftGnA6ptwcNzO87v+MvSwyMgJSJRzp0jplvI/ovFb72YAjHlHh0A/oE9p3WADN4lGp/ID+ToIc+huoyQHS+xXt+RPU1gMlK86maaFXjSKxymaQsyxjLadB1Rw7oMxgmt16vfNru7jj9EmK1TjVNDdais+YziCw2uCdZRuyomemCdazYLCuyeuruJbXArJuSJecrWmntqT0AlB1TGVKZ259RQ24IBwNOHbwIMqTAvhAuhs5RsotlXnaTf6ACR7qfhiIEJJx/5m3dWxh7VD97jDrtscCOt8XhDIIbmxyKEssAlH1gl0XyB6LSxNy6WuS5fnysuc+UARnJhr7WmyZerkStyKaEhu9SzyFmIZ5yjohIFN+uA/W6E+QVlDyH9XPvXexwXTCD4HI+UkPNW8LwylKpi/DmMdOje3OMTj0GOyQ5aiapQAgkWAjEUibtUjUp8MZkPINwVntk6TN4fp4BdK+7MSs8sWA9SiuoWyx4AIyy4rVeoS8qXJQIlpsAD1m6llD8wE+ZjzkGTsPa2kwILYInCwjSiIx3179VAMfxLQzboNf7Y0DZ2qjYpHejpGKZ0JJC9a0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(508600001)(38100700002)(66556008)(2906002)(186003)(83380400001)(316002)(966005)(6486002)(31696002)(66946007)(66476007)(26005)(16576012)(956004)(2616005)(53546011)(31686004)(8676002)(86362001)(6666004)(6706004)(8936002)(4326008)(5660300002)(6916009)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09PRDBQNlM1NmRhUTFmdU5ZdzRINlFoQWdSaXowQVdUY2NHQWphR1krekJo?=
 =?utf-8?B?WDRLS0l3NytvSzl0OUV1NXJzTmhoL1V5MW1ucnpqdjcraTNWcEpQUXhYbzF5?=
 =?utf-8?B?U3BSU04rb1cveDRwdkZYRjBEcGNkdDYrbGROM2M0eTU2SSs1SCtkUFJUVmNH?=
 =?utf-8?B?NGpGak9MWlFtNmdsa1d2NUJ2VjhWL1paR0VubXJLU1F2MWhMeEdoV0N2cTlt?=
 =?utf-8?B?VHNGeUg4UnRPVnNsbi9XT21wNEhTT0tVb0RvL1BQUG82T2c4a0tNRUlNU3VY?=
 =?utf-8?B?OThxV3QwV0dJZWdZM1hwL3VDbkNubWpUNjNzQVRUaTQzSHg5dGNIU0hTMUor?=
 =?utf-8?B?WG5SaGZ4RnNvUTdkNU96ZDJSQmJOaGFHMXNxNjMzVXJOQnVUbERqYVBGWkdX?=
 =?utf-8?B?YWtrZSt0TVBZM2JUVEQwVER4TEY2MTE1bmh3dDJLSUZzTDRQcEFsamFaSVha?=
 =?utf-8?B?SHhQcTRiaklTNmJ3VzQrelhHVkNHcHovNHYzTEhyTUVROVFqbjRIVDZTNEdZ?=
 =?utf-8?B?QS9Kd1JXTytkaU80SlFjcUFGdEg0cmtDRldHVE5EaFo3Nzd0S3ZCRVNNaFJJ?=
 =?utf-8?B?aGRrL3pIWUlqbVU3TXVibzIzUGE4SS9FcmhVbWMvQmRTNFl0NzlqZ2cwTGUy?=
 =?utf-8?B?ZnJ0MjJpUHpXNkhzR2s5YnZlcS95akt4RHFXeDBVYkNVcENNOGM2U2FHQWJF?=
 =?utf-8?B?TzVUcDhNVTl5YmpCZHdDeU5qUEpCKzQ2RHY5c3U2VmR6Wi9tdDc2aXlFc0pk?=
 =?utf-8?B?dDl4QUFDSXFmamxtNnhJZ1N1d0Q4a0pzQk9vazVuNXFkNS9aelMxVzFGazlP?=
 =?utf-8?B?MCtZbUVpOHRVVVpERmV1aiswWmYwWXBpS0o1emQ5dUFnUGhoWlQvNEpaZ3hl?=
 =?utf-8?B?eWZiTWU1bXBBQUZBaE9ReWozWVMvYkhCV3BQUWpVdHkwb2Z2NlRTaUxNb3ZL?=
 =?utf-8?B?Rzc2UldONE1KMWxMdHVrbkVGQUpzZ1dhVWZSQW01Qk4xWk1pWiszcWFSeFZY?=
 =?utf-8?B?Y3JiUEhQRG01QXFKS0dvZVVlUi94VGxhSXNJclhOT1paWnhPTFVMeTcrQ05n?=
 =?utf-8?B?aWE4SmdZNWUwQkZjVFo0UVQ5c3NWOU9qbTBtazBZUDRBODNoMnpNa0RzeE5S?=
 =?utf-8?B?YzRiZllocWlZK2dqdUVXVm04TE8vMCtUb0xMQllXbWFvcW0xRmd3ZE82Uzhh?=
 =?utf-8?B?RVVhQi9mQisxTjFnTUFNRjlRelIvaDl1bk9yR2RjbWNIc0x5bW1rb0NHS1hI?=
 =?utf-8?B?c1pUUjljZWEyKzM3MDF5WW1FMml2djNUUmphVDc5b2Yyb1pVbkJwL1Z1c1R0?=
 =?utf-8?B?Qmc1S2d2Ulowbm9Ldzh6UG5ld21IRXlTNCtxVjFxRnEwL2pLSWhURm1QVGEz?=
 =?utf-8?B?dHJCeU1ZRjVlcEN0VWh5YXIwVm1lR3AzeVhVbHhsL0syZkcreTFGRmtzc1Fo?=
 =?utf-8?B?dk5oQXZUQUw4L0hqZkx1cVJpTkdZN1FpRGRRNHJXSUdHalpJOG4ycDRVNXB2?=
 =?utf-8?B?bERVUXU4RGE2V2JIZG1wbktTYkpHRjljekJ0SnhzQi93bzI2UzU4M0tNSllN?=
 =?utf-8?B?ZkdWMmtIelR0YjJueTkvVllrd2NIQU1mWmpIcmx4dEtwejQySEhDWHJHR3Nr?=
 =?utf-8?B?Z0t0VEFacU44ZnVMQ0VxdGQvVlBSTTEyN0lTblBpVVdJamNNN013Wk5hL29L?=
 =?utf-8?B?OFE2Sm90cEl2KzB3cG5FbWVTMFBQMnZRMjdWdllBMWhiREFZQXFVaSs5aWxP?=
 =?utf-8?B?d1hkOU0vRHpPWVdIQkJMYnMrb2FwYVRhTFIrb0FJc3NTM04yUlZzcVRJNVZJ?=
 =?utf-8?B?eHdIU212bmNUNkNXc3g4NTIzck83UFQ0UytMVFI1UFU0V3JGMGM3ekl5eGUz?=
 =?utf-8?B?M0E3clVOb1pHcTJDTGRkcDdGMVlGS3MyMUFoQThES2JEWE51YWNKL2xwdWN1?=
 =?utf-8?B?c3pEbFp1aDBnd1BTdmxBYkpsckJOeDhicG9rTUhTSUc0VW1nZURjc0pyeGhZ?=
 =?utf-8?B?MVlydVI0elhTVWNIZ1A0NWdBVi9nbms3c3djUnlmZ2JldnIrQndHYWVtRVZn?=
 =?utf-8?B?ditWZGFycXlsTEYvWE5YNExQbnpCNTBLTjU5YmVaR1pvb091UysvcWo4YUty?=
 =?utf-8?Q?mZUA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df69c5fe-84cc-456f-8503-08d9b4a8a3e3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:57:44.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb8E9EVCp+VExfRo3d0kiXeDic3Mm+EVu2E0eHeHnMuCdhcsHcCvh+lR7BmlhhJ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/1 13:17, Qu Wenruo wrote:
> [BACKGROUND]
> 
> Currently btrfs never uses bio_split() to split its bio against RAID
> stripe boundaries.
> 
> Instead inside btrfs we check our stripe boundary everytime we allocate
> a new bio, and ensure the new bio never cross stripe boundaries.
> 
> [PROBLEMS]
> 
> Although this behavior works fine, it's against the common practice used in
> stacked drivers, and is making the effort to convert to iomap harder.
> 
> There is also an hidden burden, every time we allocate a new bio, we uses
> BIO_MAX_BVECS, but since we know the boundaries, for RAID0/RAID10 we can
> only fit at most 16 pages (fixed 64K stripe size, and 4K page size),
> wasting the 256 slots we allocated.
> 
> [CHALLENGES]
> 
> To change the situation, this patchset attempts to improve the situation
> by moving the bio split into btrfs_map_bio() time, so upper layer should
> no longer bother the bio split against RAID stripes or even chunk
> boundaries.
> 
> But there are several challenges:
> 
> - Conflicts in various endio functions
>    We want the existing granularity, instead of chained endio, thus we
>    must make the involved endio functions to handle split bios.
> 
>    Although most endio functions are already doing their works
>    independent of the bio size, they are not yet fully handling split
>    bio.
> 
>    This patch will convert them to use saved bi_iter and only iterate
>    the split range instead of the whole bio.
>    This change involved 3 types of IOs:
> 
>    * Buffered IO
>      Including both data and metadata
>    * Direct IO
>    * Compressed IO
> 
>    Their endio functions needs different level of updates to handle split
>    bios.
> 
>    Furthermore, there is another endio, end_workqueue_bio(), it can't
>    handle split bios at all, thus we change the timing so that
>    btrfs_bio_wq_end_io() is only called after the bio being split.
> 
> - Checksum verification
>    Currently we rely on btrfs_bio::csum to contain the checksum for the
>    whole bio.
>    If one bio get split, csum will no longer points to the correct
>    location for the split bio.
> 
>    This can be solved by introducing btrfs_bio::offset_to_original, and
>    use that new member to calculate where we should read csum from.
> 
>    For the parent bio, it still has btrfs_bio::csum for the whole bio,
>    thus it can still free it correctly.
> 
> - Independent endio for each split bio
>    Unlike stack drivers, for RAID10 btrfs needs to try its best effort to
>    read every sectors, to handle the following case: (X means bad, either
>    unable to read or failed to pass checksum verification, V means good)
> 
>    Dev 1	(missing) | D1 (X) |
>    Dev 2 (OK)	  | D1 (V) |
>    Dev 3 (OK)	  | D2 (V) |
>    Dev 4 (OK)	  | D2 (X) |
> 
>    In the above RAID10 case, dev1 is missing, and although dev4 is fine,
>    its D2 sector is corrupted (by bit rot or whatever).
> 
>    If we use bio_chain(), read bio for both D1 and D2 will be split, and
>    since D1 is missing, the whole D1 and D2 read will be marked as error,
>    thus we will try to read from dev2 and dev4.
> 
>    But D2 in dev4 has csum mismatch, we can only rebuild D1 and D2
>    correctly from dev2:D1 and dev3:D2.
> 
>    This patchset resolve this by saving bi_iter into btrfs_bio::iter, and
>    uses that at endio to iterate only the split part of an bio.
>    Other than this, existing read/write page endio functions can handle
>    them properly without problem.
> 
> - Bad RAID56 naming/functionality
>    There are quite some RAID56 call sites relies on specific behavior on
>    __btrfs_map_block(), like returning @map_length as stripe_len other
>    than real mapped length.
> 
>    This is handled by some small cleanups specific for RAID56.
> 
> [NEED FEEDBACK]
> In this refactor, btrfs is utilizing a lot of call sites like:
> 
>   btrfs_bio_save_iter();	// Save bi_iter into some other location
>   __bio_for_each_segment(bvec, bio, iter, btrfs_bio->iter) {
> 	/* Doing endio for each bvec */
>   }
> 
> And manually implementing an endio which does some work of
> __bio_chain_endio() but with extra btrfs specific workload.
> 
> I'm wondering if block layer is fine to provide some *enhanced* chain
> bio facilities?
> 
> [CHANGELOG]
> RFC->v1:
> - Better patch split
>    Now patch 01~06 are refactors/cleanups/preparations.
>    While 07~13 are the patches that doing the conversion while can handle
>    both old and new bio split timings.
>    Finally patch 14~16 convert the bio split call sites one by one to
>    newer facility.
>    The final patch is just a small clean up.
> 
> - Various bug fixes
>    During the full fstests run, various stupid bugs are exposed and
>    fixed.

The latest version can be fetched from this branch:

https://github.com/adam900710/linux/tree/refactor_chunk_map

Which already has the fix for the btrfs/187 crash, which is caused by a 
missing modification for scrub_stripe_index_and_offset().

Thanks,
Qu
> 
> Qu Wenruo (17):
>    btrfs: update an stale comment on btrfs_submit_bio_hook()
>    btrfs: save bio::bi_iter into btrfs_bio::iter before submitting
>    btrfs: use correct bio size for error message in btrfs_end_dio_bio()
>    btrfs: refactor btrfs_map_bio()
>    btrfs: move btrfs_bio_wq_end_io() calls into submit_stripe_bio()
>    btrfs: replace btrfs_dio_private::refs with
>      btrfs_dio_private::pending_bytes
>    btrfs: introduce btrfs_bio_split() helper
>    btrfs: make data buffered read path to handle split bio properly
>    btrfs: make data buffered write endio function to be split bio
>      compatible
>    btrfs: make metadata write endio functions to be split bio compatible
>    btrfs: make dec_and_test_compressed_bio() to be split bio compatible
>    btrfs: return proper mapped length for RAID56 profiles in
>      __btrfs_map_block()
>    btrfs: allow btrfs_map_bio() to split bio according to chunk stripe
>      boundaries
>    btrfs: remove buffered IO stripe boundary calculation
>    btrfs: remove stripe boundary calculation for compressed IO
>    btrfs: remove the stripe boundary calculation for direct IO
>    btrfs: unexport btrfs_get_io_geometry()
> 
>   fs/btrfs/btrfs_inode.h |  10 +-
>   fs/btrfs/compression.c |  70 +++-----------
>   fs/btrfs/disk-io.c     |   9 +-
>   fs/btrfs/extent_io.c   | 189 +++++++++++++++++++++++++------------
>   fs/btrfs/extent_io.h   |   2 +
>   fs/btrfs/inode.c       | 210 ++++++++++++++++-------------------------
>   fs/btrfs/raid56.c      |  14 ++-
>   fs/btrfs/raid56.h      |   2 +-
>   fs/btrfs/scrub.c       |   4 +-
>   fs/btrfs/volumes.c     | 157 ++++++++++++++++++++++--------
>   fs/btrfs/volumes.h     |  75 +++++++++++++--
>   11 files changed, 435 insertions(+), 307 deletions(-)
> 

