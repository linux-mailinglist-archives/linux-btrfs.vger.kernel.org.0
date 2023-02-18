Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7713C69B68F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 01:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBRAFN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 19:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBRAFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 19:05:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC647432
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 16:05:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihq6KsAFH+S1dUfXrZ/ga1ep3idl60fqvZh8KW3SWXlSbwyYpuzKKdD6RvOtNaP5QYmgaaLXcBUFkhUY65AIm+SKLsI5E54K3r7lLPUj5e/eVngmn+8C6B5KTE9gxQEEeaBqB3ejenB1ydvFtg2KEaoUeA3ECzMy5dUIS1E+Q1U3npO0TLsBCc6jo4le7g6dP5dGSoYfBkteZW9+n5n/UZeQOsRPygTtRIoi0vbHZhERHShMkPK9ucUzg2ZHe1pyZ3Ti/3y9Gjru1lS+/lRIST3ShiCqAMJZAKheDzKI+H5HexRTp/0NQxKjR88hmh0CGFCAWXkdoxjHQ0MUwX1lmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxEiLS5UOMJYr2SAVukmv9tPuaa2PKntBNZUuEZnkWQ=;
 b=SWKwvhs4PjMSj7oMfTQCNpMJSqUioWOks6GTIjwWPsoSUcUKhJcjC9sYgwYUngwgwFgp7tQ+p0+jFmx9CiA0o18AuyATamAE0SjIuK5cKczhSELi+zYmntsjGzDwkzkCIBsp9fnq+boKl56l/T9Nc0FZDZYZeW77tHvx+TGm0xjkZQSw0NRr2yzrRTcyP+9AO146E1OuxxKoBfdQ9EyWCGm5tF4rAz9PRltfPw3ZElVanXcU7hpy0aNooGk+bd8EIdn6VcSEm4iqGo/C9AdQXd2PGJ7zNzXBLSfP20gjrsyysJJ8EOoDIcB4YhmNGwMFqzadt+JAB/wx++knGHBu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxEiLS5UOMJYr2SAVukmv9tPuaa2PKntBNZUuEZnkWQ=;
 b=zClh8HnKO4IuejOlK+9rOH/Q+b4vPgZQq/JfHH/HJadB9yRjJo0pFf49bjbdBi+Gfrgbs5lhMVlZFZ4zg7hBfGuO4r2wj/xqZDE3JkEy8DrNVEkFh5Jwox+D0VvrFh7zmoKPTRqlNUzSOkmlFW6ho3D6vJINWW9O44+DXss+TDRnZeISngEiNAbew9ok4WxnUPp9ri44r4ETYYzlPb2esjVpTxNxmRh8ljM5vMvp3ighrQ+uwcb5RMAxAmXxKTx1hM6njgAJgPZhLkLGTo9VUgkS7FXhD7n3cWn7PB7SGVrGwFTu9GHSzYBWL9pSMT+ZN3gO2QLR0QVuADtjOSz3RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Sat, 18 Feb
 2023 00:05:06 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.018; Sat, 18 Feb 2023
 00:05:06 +0000
Message-ID: <9b45f60f-c849-e072-64ef-298937e6a8a3@suse.com>
Date:   Sat, 18 Feb 2023 08:04:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: Return of btrfs_del_item
Content-Language: en-US
To:     Kang Chen <void0red@gmail.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <CANE+tVrwoRxcOqK5vJCzEJonD9Z=80mdXUqvE3RoOcrVgRhrBw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CANE+tVrwoRxcOqK5vJCzEJonD9Z=80mdXUqvE3RoOcrVgRhrBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBAPR04MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 14567125-45ec-4fd5-294f-08db1143ca51
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwH4a1cixIbxMLBhGYvR0MWK/TFmtoepT6Oq2V0zqrPzqW3wwY5jVcqtHgS6IPf9YK7aLbLmSiVdnX+TiJeoGuKFoX3mnS8V3PwccrYXb/Zifxdv/2b7X+tBTSUTmLID8C1qOh06ZfQeGoB5rn8FJbJCeUpWNxKbKevYe6hzhniarzkO4eSHe8gU5zhS4qDsIymE9wv8wcz5jDQsqT68u8sAQ3AOJIJn+A7Dgp/9XIxH15Q6aigZ39iwcCVNJNfl0OcXnzk9MQhBE/r7EGHwWMbToPz1fLrmyjKjh+ZplArYYq5JM8V8nS49AGxMeYEQQhsJBfiy5W4+FP7wQsaraBo6+oEs7DzM8keVjK7/j06ov94kQy+sgJcc/4Lof7rX7lTO/T1ngaXaVclUiMHjY/E/3MYuX6+1Ve1XuPE9Ym6hQxbS8YRgKbgUUcaDAAGe7nuTuzPbAcB42FguEhsjEGXCYZ3O/tBpAX1gMfp1Vc2kRf/4vWyN/Qon9HR+f+2QpuzN8IKf1cO2wKE3NSizRDb4Au77GY7qfGfEpNa4xhjiMKYfheZm0wcszIO+8GawbDXkxjl3657ocWrG5ixU6+oc5Gogwrjs7LZhUKFB2i4Ozs/vlwiGlEpZWI/LSQIJivj6aHXM4fJ74kucUdPcMFQ1inkRY361bKQY+RhJwL2jHTfKS2vJRSFIrb86cT0n7gXTOpTKmH+oOwVO+sV48dy46vxLANO8f7zl33l6U30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39850400004)(366004)(346002)(136003)(451199018)(6506007)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(7116003)(8936002)(5660300002)(6636002)(41300700001)(6666004)(2616005)(53546011)(186003)(478600001)(6512007)(6486002)(966005)(36756003)(86362001)(31696002)(2906002)(4744005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZiQy9NRDVneEZBbjlTVlVlTlMxR3RGKzlXRGJsem5jSVhFQWUxK1lJdldR?=
 =?utf-8?B?eEhDdkxwL0dPS0QzTUNhTGtNeGNRYkFvWlpLTktBZGY2T1RVaWgxTHphNXBS?=
 =?utf-8?B?OHI5VEFMMHVmeHZtZm9ZOHRQL2dsTnRXYlFIeUJvb1Q5QzBabk82Y2JBYkJ1?=
 =?utf-8?B?ZzlTSVY0b2JYTmtWdk1Fanc3YmptQm13RzRWZ21yOHBZUzE3Z2RDNGdqZm9y?=
 =?utf-8?B?VzJTdzY3dU54ajJLOG9WN1FuVzU4TlpmSzdGTzFrSW04WkwwVDFqNkVwdlJX?=
 =?utf-8?B?MHhFaDZlTjNPMkxJNXFHUVJ6clJJT0dOK25zSUQwRGhLbnJnRW1xV3FQV21E?=
 =?utf-8?B?cTZ1S0UybEVWZXNkMHdkVGJUQXd6RzRYWTZ1ZDVQcnh5ampqSDZ5d2FFQURJ?=
 =?utf-8?B?Tm9ZNEZsQ1NCdmFsZ3RsUHppdVVQb2t4YUg3N1ZSL3BDQVRRU2Y1RlNRYWRQ?=
 =?utf-8?B?MW1Kb091dU56S3lxMWVEVnlTdFY4a0RCc0xBSmdWejFXOGtpQWliRTNoa3Nx?=
 =?utf-8?B?blBhMmk4WDBZZFRST1FHRSt4V216d1Y5Y1ZSdGtRM1NmRU1vbXl6bDFodytI?=
 =?utf-8?B?Tnh5d1AzenlOSXBRMTZ4NnliZGZYY3g3RktHK1c5QXZBdWlBdUFKcWEzbGU2?=
 =?utf-8?B?bDN1NXBTV2gxanlMK1hxQ1hSRlh1RmhCVlFRU1lmOWJkcDVvWjZ1NXhXbW1Y?=
 =?utf-8?B?NG82V0lxV3NpNldSRVhxZ2NlcnFYd0lVOW9nVFNNOWxNLzJGK1pWWncxclh0?=
 =?utf-8?B?N2ZBUEdVeXd4RmdkQS84MFpTZktXMjFMcGRCVHVPVWxuRm8zNlVrYS9lTXV0?=
 =?utf-8?B?b2pwRmNySjNha1BCeHhYREVoUmNwY0hsajZDa3dUOWVJa0pXYzVES2EweTNT?=
 =?utf-8?B?Mk9jdjdGNFdnSE1Pa2tXYjZaeXdKZnVpQmdrS2JjUEtMUXFZSEwwQllmbWNy?=
 =?utf-8?B?ZDJGSit5V2I2aHU5Q2tTa1paYWY1dzRES0F5UVY4UjRrUy9PUkJ1V1RjUWFB?=
 =?utf-8?B?QndzeWtIYUxwSDNRQ2MrV2psNGQzV0oxaWpoaFVaVm1oZjhiRWpFbzAwSm03?=
 =?utf-8?B?eUpLazVXV0JuekIwQmo3dHowSWlzbEVaK1lUMkhjTEcwbWlMWmVOdWpSbi9x?=
 =?utf-8?B?eEozbmh0dTJZbXV5YzBrTnlDMmcrK2VOWS9pRFdyNnRlNnZWUDVrS00xaGVu?=
 =?utf-8?B?ckUxbS91ZUFCTFhWaWpYaE1MY2wyMlVuMXBaQnJrSjlwNnJpUkk4eURwcGZL?=
 =?utf-8?B?WXFQRzVFRGpxem55SFR1SVdmRVRpZXhqNklJcEF5am1sSmVSZVhEWHZSN09r?=
 =?utf-8?B?ajVQYkQxM003TStFeXNhUDBOc1FvRVNHZ05mMWoybTdGUTMzcVMraTdTU2g4?=
 =?utf-8?B?UTg3VjV2SWJ0aDRXWW1RL283d3BueDZNQ3FBVEN4S1VTTzY5K0FyNnp0akpB?=
 =?utf-8?B?R1d3TllJQUJKcmFKeFBYSmRNc1pLTnRuQzdyTnprcmlDMUVhc0gzOExxV1lX?=
 =?utf-8?B?bnNHMko2SU1SdG5NSWJuZDlKMVhCVXFXMFZZdWw4eHMzYVFrQ2ZlL0lvNkQ3?=
 =?utf-8?B?c1JNL1U2T2VGVDZTTW9XWU1UVXlrSVEwM3pQS0FLYVArbEJzcFR3SkVoZi9P?=
 =?utf-8?B?cmRVZXhsSFJNOGZzRXJ6b3BySmgwMHdySG9vVm9NMlk3UXdramlnMHBhQ3o0?=
 =?utf-8?B?b1A5ekJlSTVaeUZUYUdMNHp3Qzk4L0dVMmdFRXo0SHQ0UDZiVm5hcXBXaXFS?=
 =?utf-8?B?ZXRuRjJZd1VxSXVsT0U0eElybkxsUzkvdTNkT1p4YlJPWGZ0RXZsanVLbE1E?=
 =?utf-8?B?c1NDNVY4QU9XeHVqazBvZ01WeWdjUjFjc20vWEUxTGUvWlFDY2lDT1pkWVRB?=
 =?utf-8?B?Y2JkV2dRN1N0L0pBQ1Q5cm5OSTEwZk5xTUgyTEdtU0JjTGZGc0RBL2xHWm9M?=
 =?utf-8?B?Tmh0UXdFMUJ1VUQzSEZ6cGVCZlQyaXU4YndpRWtCQmprbUVqZXJmNVFaRmVZ?=
 =?utf-8?B?cE01Nmd4RXhkdUhZYzduOW9jYXBXem1sb2VTMkFneDc0d2tLTUp0QmtDTjBr?=
 =?utf-8?B?MkVFcTFBVUZFZ3Z5SkdSMGorald5d0pVTGMxTEJrWE9qaU5ERUtIUnN4UHZQ?=
 =?utf-8?B?R3N0MUhVbmk0bVo5aWRKeHpzeDFiSDJCL1hXanFzQTQrODZlaFlPUFMzWlZE?=
 =?utf-8?Q?8/nD6WGctH6SAaq/fbpGERw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14567125-45ec-4fd5-294f-08db1143ca51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 00:05:06.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEnN5lu8/Y+Xumt/VvgwSZnBRnkI6Sw25cAc0QaZ0m1YphKXUv/9I1DOnqx/MZm4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/17 19:47, Kang Chen wrote:
> I found that the return value of `btrfs_del_item` is handled
> elsewhere, is it needed here?
> Maybe we should save the return value to `ret` and abort the transaction later.
> 
> https://elixir.bootlin.com/linux/v6.0.1/source/fs/btrfs/delayed-inode.c#L1075

It looks like a missing error handling.

Even if the slot is already read out, we may still need to re-balance 
the tree, thus it can cause error in that btrfs_del_item() call.

Feel free to add error handling to the call site.

Thanks,
Qu
