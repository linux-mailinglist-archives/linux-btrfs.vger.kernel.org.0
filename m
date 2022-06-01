Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987D539B25
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 04:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349041AbiFACOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 22:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiFACN6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 22:13:58 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D84D621
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654049633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNe2q6U2dTrZRHcMjfKPNx82zpzY2bkiwXH/QNAW0Cg=;
        b=dj/mEHlnvGbAVBkZC7/otlHV9KruMG59TJ5SUdUXZWhNDilHrDeOxIWr0b4PleNccLBuuG
        yjvNuEVXca+kAX1fijNI8hgJeELfSPSEm3YXsnySOQJH6f5wuxkQQ2ZUn96yP6KnrVM8Af
        k/ilC1StKYdUG91FR/tkMncMv2Igl7s=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-nEGukPZsONmrnVmrrYqnsg-1; Wed, 01 Jun 2022 04:13:52 +0200
X-MC-Unique: nEGukPZsONmrnVmrrYqnsg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3kLEWhdpjs7X4XJFJJLa0DRooinhJ9DLteqCffoFjb2dxO5eViSNTLoBV2ooPd9rz5I8hFo7amd8T3CYv7TWBwmxqYnBKEh9X0IsbdDL/GNeZtvBr01kUR+svMFP3vl65NV7zlNgVIHJEMN+ys8H64rATkZ0pLITR+kPRPOJWKvJX2S+8yaXt339s+fZITUGei3Uza667MF0Fgh9B2t+ALqfo75DJVbylU2+Z9AiMlAXjzUK69cb/Mt21RKcMFxeeYzholNfbvSISmWNvz6zM2hLZnYJHxnExKI0/40eTNiBQ9qnClYsdPjot+RNDCWh1tFOL7s+p6NPZ4loRvWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNe2q6U2dTrZRHcMjfKPNx82zpzY2bkiwXH/QNAW0Cg=;
 b=TDWT00QR80MCG13y22cqstqUUHsqMRHGOdXhB8a47BG4ue5VvfGN9DC0+oeD2yfQa5YiJYkMegOJmScA50hrhtwTt989u4a7dirGlMUKYpX1oHIMjn3y+UXxaSooG5KylJVJ4OuMOK0DserEpGGTr7fdzf9E5egevC0pTfW6UGUik5rFhiCR+X2GzqvkIQ/namJHaYXSlLJUDtijI7Qv0lI5HFcX8HWJM7iYihCc4s/nWOaw2fbie/wpxBb34fBS6foGE+FNhG2POuPsqVuvzK/i2M7W89zzHmcp3oAo87J170GsX7DtWKbrpsqVOgAGZ/GHLZOYy7hhhfkJhzKVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13)
 by VI1PR04MB4926.eurprd04.prod.outlook.com (2603:10a6:803:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Wed, 1 Jun
 2022 02:13:50 +0000
Received: from DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::4985:a4af:be9e:add5]) by DB9PR04MB8478.eurprd04.prod.outlook.com
 ([fe80::4985:a4af:be9e:add5%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 02:13:50 +0000
Message-ID: <1bcadb40-e478-1c56-27fc-ca87e7fae715@suse.com>
Date:   Wed, 1 Jun 2022 10:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220601100645.6500.409509F4@e16-tech.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220601100645.6500.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS3PR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:604:de::11) To DB9PR04MB8478.eurprd04.prod.outlook.com
 (2603:10a6:10:2c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7cdd4da-0f46-452a-0dc3-08da43745dfd
X-MS-TrafficTypeDiagnostic: VI1PR04MB4926:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4926D0B3033B70C1E2E54DEAD6DF9@VI1PR04MB4926.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beyyVa/pXmt3eapZw814Q5LmlVYpgXgKkPaJWahCXYMahO9voKYyB7TgPEylzoFCDPbqnBct1Mc3Zd+bdYUF63+AU8I75CnFdSEYd1Y66yaw3dQMAa/cqfnG9KsHzo4IfHuf/fXCNfkHhkkCxMjcV7o9Yspq3klzziZQ7BDqMa6G8tYg94dhIfafkVM2oxRKwFTSO0OHNTCTWElONysd0fSaeOPPdo1o0ZIMXYV10CeTXOPeiHhGb31zgEMaqI6YX0q9F9a9lt1eYPVATGthqj/ID0LIYM0LqAf9TQAnWttajFOYqPMNhBXzaoxVKSB5fqtkyeH2fIKdDrTGkpf6CgTiG1Bd4yJdyhZwybEwAUdSakDUI7nYHdZzHisI6/gJFxiWSLj0XdYb0kIzRHNpA4tYDifR+5JBxXCI4yTYSHdfX/BruXvfN+2JJa91HBSOZIOXuhRvzfG7dSIYj50/UGzaBn+YhkZDlKUcFio+dh6MUHcpc5/cC9uLNuP3OrhSAzQ4h5L/93OcshjCuqPowGzrI+Fmrnqy60wh012fBRH27BtUw89JCZz0zt5y1Nze7rAFlPhc5i9vxaZGuticYnz8ib/pYjK4DHAOLxK4fcYzM0M1gYEnaEYrMNyZ10iu52kp5R7eN55pbxcA1BUBgju11LMZ7Sc9lYh40xboo6kQIDNC1NmBTkoAelMGEhGSa9tl193JCHl6ElswjXLs3oOwYIpXRHHqI6RS5WBiMqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8478.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(31696002)(6506007)(86362001)(53546011)(6666004)(2906002)(6486002)(8936002)(6512007)(4744005)(508600001)(5660300002)(2616005)(6916009)(316002)(38100700002)(31686004)(36756003)(66476007)(66556008)(186003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNDamVtYjZuR0tIdk00SjRxUEoxaUxSMzZGdVREMEwrMVJRMmRVZkNHQXM0?=
 =?utf-8?B?MEllT2JXcS94ZjNHT3prOWQ3ZUN5K2FvWmdaSmdBZU41TGVVclV6VGwxWnhF?=
 =?utf-8?B?bzlLNHZyRUxCVkRORWZ1SU5EQXFOdE9VR1poejhWMjM0am1lZWN4YUNDOUxC?=
 =?utf-8?B?cVMwNWpRcklORkVNcTE0c0pWN3FjbEpxY2xSbm4zYWZTeDc1bHVYMCtSZlU3?=
 =?utf-8?B?Q1c3VXY1bktLczdDOStzUGN4aWtJVUxXVnIxZmZqRU5STWQ5Z21DWGxlNlBu?=
 =?utf-8?B?VUN3b2FibGpUR2lreCtqdEdtWHNWRUN5clJUY1Q1RnFtQlV1Ry96aXF6Z09N?=
 =?utf-8?B?Yk5LMGNTdzhSSmd0Q2tCeTdsWXIzV3RkWmx2U0Z3eFlCZ3lOTnJSWnk3S3hD?=
 =?utf-8?B?MFlxOVorNEJHbWhJREc3ZWc3enp6c0ZaNVE4M3ZRNVhvT1YwQ2lKc0JBL2Q5?=
 =?utf-8?B?dVU3aUdQRnZYZHNNLzNKSDhMK1pDb2dLNmZVOWltNDdqYVl1eW9SWkwrbnBj?=
 =?utf-8?B?WmdjeEFOL2haUFM1RGx5dnJINk5kaSs0RW1lUFhRa2l4eTFGV3BrMDIyRXlN?=
 =?utf-8?B?eENpaWhrdFVLVWc5czYzS2F1cUwvbzRXRHFlcjRtUmFEWDVHdVRJeVkvN041?=
 =?utf-8?B?TWx3S3p2R0c5VGZiZG43QkpFempIRHRWeHBrNWt2LzRaYU9pOExva214OEJw?=
 =?utf-8?B?R2RiSGk1anJFd29qNkdGT2lyeXlkcCsxbnFDRFpOd3dzajBmRDB6L1VCcGhC?=
 =?utf-8?B?VU5tam1iRk5ZdVdsRWlqcEQ4Z0RmUU8vT1lqMStOblBHRE9vYTc0c2orTmky?=
 =?utf-8?B?cVFLVlFwd3dKOGtwZFJYSXBTZXhrM2U4dENEVWxESUVnRHA5dk9mc2wwMGZV?=
 =?utf-8?B?VlJabUZEaGROMlhDQmNFLy8zWWdyM0RGOWkyTm8ycDg4d1RSaXlrTVBwblVq?=
 =?utf-8?B?dnN6dTZQc1RBUkxydzhsT2RzTFRLY1AwNU8yTFJQQjZEbFNJbWt6Tzc3RTRu?=
 =?utf-8?B?aTdZamtKVzFtZVBkVEpORmJZVnUvWHFwK0JZMFFXbFpXNmRnMldGQ2dzTWJ1?=
 =?utf-8?B?K2VsZDNYOTRIbUhQcncvelZkdHpEcC9EcUhsS09KdTJhUVZKZEwvRDZoYm85?=
 =?utf-8?B?UzZ3Y3NSaGxwZ2NaclBEYWI3Qm1EdnRRVm9PdjdlRTNxdG5TMjErdEFHdzdS?=
 =?utf-8?B?OVB1bUdoeEZwUytzaHVNdnVXOHltN3lPb2hLdjZWUnMxRXh1UlFtMXJrOHIv?=
 =?utf-8?B?aE1uZkVjTEJhMUpXNCtGdVhJNkFqNjlobTRRRDRpNUpTbjN3aVZxN3BGa1Vv?=
 =?utf-8?B?M2RNK1JVZnpxTVBrNVFOUU1uTVhvTkR0MnBLOXpuaFlEcGhjZmp5dDZIOUxi?=
 =?utf-8?B?MHA0b2hsdzNTTzMzWnRVV0VHM0t3aFhocno2QlJUdmdBL2hJb21lZUlHdVIv?=
 =?utf-8?B?SWdibitCOEhScm03eUJoM1ZEUzVtTFdtQ21EVThQRnBZdkttNzl1eTVkUW5N?=
 =?utf-8?B?NzhWYjk3SDZSbkdhaHVGODcxZW91ejdTNUZsV094Nmd0dStQMmdKcXdaSHFL?=
 =?utf-8?B?RHNYejJJT2s3VHlxc3Uwd05GbFpuNjRIVjM0Q1YwZ1YvaVJydnZRZW9PTGdT?=
 =?utf-8?B?WStQekZNQ01oS2lnT1VldHlYaFdLeDdWVDJRZjZqK21iRStvc09oVFpPVml1?=
 =?utf-8?B?Y2JPdnU1WkRNMEt6RG15YVRzLzhUQjgvdEt4VWVQMVFFdGZBUjZSME5lbGxx?=
 =?utf-8?B?N2FvbnFsR09mbU9qWkVIanF4YWZONGlicHhDdmlwd2FhQzZ4TXNnSVNCSmdw?=
 =?utf-8?B?ZmFFc3o4T04xcFdEZnEwWVVBOWl4VHlBejFiR3A1ajNtcy9QN29xRUExazNF?=
 =?utf-8?B?TitKV1RFa3hVaUtTdlBYaE96VjhaMWc3TG5TQzBRY2J5NWs5RzFzUGQ3S0Zr?=
 =?utf-8?B?NitSWktxcVIrcncydDlYc0xiWjB5aWd5ZVdPeG5EOFFScXJ6OFJFbUZydmEy?=
 =?utf-8?B?SXg0OEZaNUdMd3U1bkNzMlZ5akN6WUw1dUhBRmpEU3NzWGY4aUM2emJtSysw?=
 =?utf-8?B?QzR3by8wUmJFSmpsZnk0eC9ibmUzYlVQZXJaMUhRdldzcHFHYjNBbWpZWGt5?=
 =?utf-8?B?elEwR2xrNzNWMmo1ejVGeldlVFh5M2R5R0gvV3haalR2R1I5aE4xT3NackVV?=
 =?utf-8?B?cGdNbm9hMHJ3aUxkc05RZmZPNjdnaFNmSUQwMjI0d1ZZaXpJOFNuekNvdHg2?=
 =?utf-8?B?b0g2akxxOW1MNmZhcEtNR1lTMlRsMm5WdGtHQy9aNW02QVlXbFJHZ1pFMEZH?=
 =?utf-8?B?VTRWY2t4MW8wN01CT1lBSko3T1JmQXpVYzc2WCtWSFZ3c1R5blE5WWlqV09T?=
 =?utf-8?Q?XgxlnfHn5D5aJ4fFyVjmGQesufrRwCYoDx7ru?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cdd4da-0f46-452a-0dc3-08da43745dfd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8478.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 02:13:50.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9cSMp6DKJPlWxxKiV1xayZRE4Cnf76cxgtLlEytjYR9A4bcjzCzsua3Z7JQqYUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4926
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 10:06, Wang Yugui wrote:
> Hi,
> 
>> This is the draft version of the on-disk format for RAID56J journal.
>>
>> The overall idea is, we have the following elements:
>>
>> 1) A fixed header
>>     Recording things like if the journal is clean or dirty, and how many
>>     entries it has.
>>
>> 2) One or at most 127 entries
>>     Each entry will point to a range of data in the per-device reserved
>>     range.
> 
> Can we put this journal in a device just like ' mke2fs -O journal_dev'
> or 'mkfs.xfs -l logdev'?
> 
> A fast & small journal device may help the performance.

Then that lacks the ability to lose one device.

The journal device must be there no matter what.

Furthermore, this will still need a on-disk format change for a special 
type of device.

Thanks,
Qu
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/01
> 

