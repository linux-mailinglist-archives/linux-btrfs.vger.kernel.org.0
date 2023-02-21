Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444069DE8C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjBULOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjBULOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:14:24 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A79BDEF
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlOS4hdaNN8pAeNn69OebBmNHEaKLE4suGtIO1IUa6qe/WKQnvhe3xcRukRUEU4vxfyNTdjyyQymzQFGJ/GMuuYjVH4xpAoq16hbDjcUHIuQH9fGCVF2mnBWLR57qZvF/BVW0Y5YfgWeDxqt+Dbq6PaPoryMJOgzAaQlaMz/rYTbPWH+ZA6lz3OzdSxfZVUudHSSwOSzHqCj0y7WrCHcTC/kXTf6Mp5L70rzPoW2Kr9D/X7MH+Uk4SmaNhUSH8ElGz0+RMBt9QVf+uXN8TMUPL23pRKa/JkvtHX9kgcGMG3yeO4GwFs5DXCqzoHHEWjucWj7mhu1eIK9OLqpZIeh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkY5j5twUG82WBH8EwcRS2eDjDk0qbzterhVFOPoeZI=;
 b=TezpwGWSImMAuXbclHgoDWi0MBI/00h3d8/huNcBQnK5lbtsMmCiijEKKnZZIXXbIhdN3CE+0X0wvyDTUPbxts2sNLXwecS6Yv5SAkFTTJf+VAYLXX985LawFEnIA2mTAmwGklQydNXqgl9TCr2gXo8/uIgShI9XCer/B1kYcJIRnOaIVJdU3TU/OpGbgvqfNLABHa5jwFhhyPNxz84WLS7jUbDJ0LZ37lpD69hFsrCKgOkMLD56Z8J7wppl4Nqj4DZev+U1hxp2UVev7k06Wp1GfMHRHNMGBSUjNSpd4totnZ3r1n1cuofhfAkPzbqXInczVtqJ0546CfjHrbCodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkY5j5twUG82WBH8EwcRS2eDjDk0qbzterhVFOPoeZI=;
 b=qy/nJb3EQdh49rA4xpfsRji9g5lit1ZmDOtcg2Y18wOAARsr4kgmeCdzUGnZfJg02YRmQklE1D2zKGVqMylBAJTdDLpPsJ6ruIBBUvGle0qDsllXVI3ILhiH/9tHCWliOLq8x0vLXbf67/qzKCaFfk0YPXZUv/gvOaFcQc+8C5XJBWb8nUl1hBnpRM0nPu8J9s/7N/QdzFxBCelfOCQOtMN323cNNjRwK2Elus/q659AcaXGMIPDpxzt67Aloi1VDwtxJMU2JwB8F3V1Nd76XyX46SFTyKrkEVA6XkIFmuR/qguyoATUKOuT+/fS1kbd/9YXZyxz0fqVaCyzsEw2bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 11:14:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:14:19 +0000
Message-ID: <6754b78a-ee58-9054-1494-335f062dd620@suse.com>
Date:   Tue, 21 Feb 2023 19:14:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 02/12] btrfs: remove a bogus submit_one_bio call in
 read_extent_buffer_subpage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-3-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230216163437.2370948-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fc54ee-3b6d-4c32-5abb-08db13fcc68b
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5hNOY4wdiSSlCuWl2WFHCSDTmn2Pu4PHC4xQdoHHD7rmS6iQ04kRh1R0+lfhI4WvpMVSGGSsjdUZu+Cqo+M72akk2/eXTiFVuo+5PxAdDV77VGFaW3gS1Jl2lRCMvHGC39HMNRew4I0QM1kK5UqedBh4u9+Gh3p6NRcXN1NEpC9sa5hytX7OXi96JmSvt7v/pHvJAtsm2fVdAIIh6G0CkfP2yio8n+A8Az3Pf5E3Y5ARPyRcGXORv8nrAf/S6knU7YHA6SoNFxYr6alEXRLs/hVl9fm+1qIeXewn9JaseqF0AVmcrAByaQS0b40ey6cJeJe0saWf32MKgEMfNm3ZHO8YpxsLQ4CEo5OORsDqJ81ciEmTyrQqanHqx0sr6BUeLylBu0vh8UNsnkE02+URYN/DcMct3LqDdPIof7wlvgFm86MI86wBiqygO0fAKJ2sARAPxKMY5uEs3DQupZ6oKJPWKTBBJ6wc6LMFpMCvaJx+jscfm3GKYmKTfVY5XMrknPXfJrKpIMfC8P8yzfbteBfIaAUUvbVYx4lIprS2WsfXEXNgI522Q1ivjmdS6QU4cyI5dSkJdKEIjKKQwYI+OI98Z0LHthHqWLQgTBKA2VPbZmCgYTnpriqXxbfVyf+5Q0SSg61GOmgD2SLdxDFE4DVciQ7ux7tALXnOpku/GkIV0asVjew3M/epatlnyR/sfX28ZzWWNeZUi2u/RQbj79BI5Cr1ZrFdJKWNB+pGOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(110136005)(478600001)(38100700002)(31696002)(86362001)(2906002)(316002)(6636002)(41300700001)(83380400001)(2616005)(8936002)(66556008)(8676002)(66476007)(4326008)(66946007)(6512007)(31686004)(6486002)(53546011)(186003)(6666004)(6506007)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1idXd3cG1JS2JyV0ZySkl5QWxrcUFKWDEyNXpzU01nYzdTVW1Oenk2cVpx?=
 =?utf-8?B?VkphbjExNTRFcDZNSVJoSE9XTFZqdEpGd3NHajA3NGpId2JtakozaUtZM1FJ?=
 =?utf-8?B?bnBydm9oSi9zckFNYW1FeXdlWXpCb0ZMZUJDZmVmUkJjZW5lOFVNdHg1b1Nh?=
 =?utf-8?B?dlF2dHJqTGc4dElJVEh1VlhGRVlYRVZaMVZ6aVFxekpVOFdaSFZnVUU2d0J3?=
 =?utf-8?B?QUNqeGU5TkFPN3c3a1lEOSsydnFzQTVCWmtPRFQrRTkrYnFFa1dobTluc1dz?=
 =?utf-8?B?alA0S1FKb2pWVVROM2VDNkhYcmpJb2FBdTd0QWE5aU1jem9qbXI2SnhoT29h?=
 =?utf-8?B?SUFoK29LbEU4NE8wSGlwRFJ5U3g3Tkt4OXJ1d1Y1RE1aZ01QTnJweFhWc0lC?=
 =?utf-8?B?dXE3a2ZEWm0wL2Uvc0p1Q3JJQVA1QlFZTlBGdmJ2MlQvNGk4cVJJUFJpUWRk?=
 =?utf-8?B?NUpUU3BEVTVqUDdtM3JhVkRjTW01WnN0Zk1YcEZpSExMMFZITjRtbDljU0Ix?=
 =?utf-8?B?TXI2M1cxZ0p3WmNpd3lWUlpMaEwrVndSM0lQSVBjejhBYVB3ZFBhVHFaMHJs?=
 =?utf-8?B?V291Rm1vVStYZ3ZyZFVDN0N4SjhmaGhDbzZGQVlRbjUrVUJ1OFdxQjNMd1M1?=
 =?utf-8?B?NlhWYzdrYzRoQnZDZi8vMHJZN2p2Tk9tVEZpdmVNOElNeXl0b3JORTBQTTRD?=
 =?utf-8?B?TVEyTUhPN2pYRjZ4V1M5RCtnRngxNmZEWjhmY1ZEcHNnTi9KU1V3MEhFTFRu?=
 =?utf-8?B?ZVB6TE14Tk4wVU1ENEo5citXelVNU25rRUhzSGRESnREc213S0J5WFlEOXdK?=
 =?utf-8?B?YUM5RG52YkN1OU9uajloUVZmeXVxY3Y4VUdNa2haMjZBL25mS0toaXp1ek5W?=
 =?utf-8?B?MVlVT015NzRjMnAxbFVFWFJ5bUI2RzhJN1lDR0Q0NDRnbDVDVEdGRVZaVGJj?=
 =?utf-8?B?T3VlNUlFRWVHcG1mbHNhTUgwTndheHhhT3RDcXpYSDlnZnJtSVNkZyt5NDIv?=
 =?utf-8?B?U0ZDTmpudVVpWVUrQTJRWjMxSmoxOEVHUU5UajhVdzlvajE5aTVFYUsvdUd2?=
 =?utf-8?B?MFlHYUE5RUZ2N01iSDB1MW1IVTdEUzQySUErZmxuZi95aCtEUjBodk1XTEVu?=
 =?utf-8?B?bmVqbnYvcmcxRFpRejZ5NjZQeTZnWUdDVWJsc0RGdXI1YXY3eXZSQzNZUDli?=
 =?utf-8?B?SVNDUXQ1dE9OcHRXL0VNSWtYNVh0Q1NrWTV2Um9YWStJNTUxaWhaK2xyNXd4?=
 =?utf-8?B?N1NoNEZzL3V1ZHpscWFrcWdlWGthMm56V3kvOVUxNTZLVEdZYXBPbjRKTWdK?=
 =?utf-8?B?aGh0dm8vUzlkZHEzMHZaMFl1ckRGOVdURG5tYVBpeFlPRnJUVS9LNjRsTDFn?=
 =?utf-8?B?dnRDdTJIakphWGJmYlFDNE8yU1lVUWlQTG5rOW9wSlFxUGFLNExtaVZIV0hF?=
 =?utf-8?B?R1FVM3FISG9GeWZLaE51UTZHVVdYNEM5VHVXQ1lkUkdITkFrWWJLZ1BPRGdY?=
 =?utf-8?B?d0l2V2dGTkFMeURqSDB6SEpENG9DNHJ4TjNxT1ozSHhGU0RlTysza3NrSWdU?=
 =?utf-8?B?TVRXU3hQcnIzZyszMmwrQ1MrTWtidXlyS3JZV2VtcERuK0VLV0E1dnJENXJN?=
 =?utf-8?B?MlgxcVBJT2tEMVl6cDdkZFV3MnA2ZDNad014ejFhbnVWQlk1WE1WWk1tbFM2?=
 =?utf-8?B?SDlkaGdPWXRSTEo0MUN0MzZJaWRHR3V3eDRYMlpSc2hGTVM2QmFvQ0FXb2JI?=
 =?utf-8?B?blNkOFZxcm1UUmxOWklRcE9xN1phcmltcVM4cG1ZMDZpOE9Pc0xRZ21WcWY2?=
 =?utf-8?B?S2dlN1BTN01XSWFiUmVXQU85TGU2aTlMblNNRjFzSGJTOWdIa0VNeXBSZEQ3?=
 =?utf-8?B?VXhTU1ZiV2RPV1JIc1lEWUZ3Sm4yZ0Zra21RT1lsRjUwbis4UjZ3Ymx5MXVV?=
 =?utf-8?B?SVhGYkIySFBLVjBrUlQ4S216NS9oKzMyQ1E5aGViS3pTMHFDR3pjdHVaSWx4?=
 =?utf-8?B?T1RVRnluN0tsNjlCcmd2Y1BlQ1lYaDR6TFJmbllEdjlvNXRIdTlEYWtQbDlF?=
 =?utf-8?B?b2RTa1VVV0tIb3hGR29kNlh5bVNBRzdveFA2dWZYc2FLN09xK3pKZGVGRnFQ?=
 =?utf-8?B?Y1pMOWFuMmZwVk5DeHVwRFZQcGY5UndkeTZ4aFd0QVoxTFZDcjhvaFFhUGZm?=
 =?utf-8?Q?Jw94gXASsi/jzXWBPMiHifw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc54ee-3b6d-4c32-5abb-08db13fcc68b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:14:19.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4cjaP9K9us5GM8yY5Yt17hL5cUGTbj8Od9m1uw5dKV0KhiQ7OrvTTfHscEPA2bT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/17 00:34, Christoph Hellwig wrote:
> The first call to submit_one_bio call in read_extent_buffer_subpage is
> for a btrfs_bio_ctrl structure that has just been initialized and thus
> can't have a non-NULL bio, so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This new submit_one_bio() is mostly caused by the previous patch.

Can we just fold this one into the previous patch?

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b53486ed8804af..e9639128962c99 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4442,7 +4442,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
>   
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	submit_one_bio(&bio_ctrl);
>   	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
>   				 eb->start, page, eb->len,
>   				 eb->start - page_offset(page), 0);
