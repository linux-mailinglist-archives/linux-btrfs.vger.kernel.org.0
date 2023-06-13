Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51DA72DC12
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbjFMIKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjFMIKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 04:10:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DBE7D;
        Tue, 13 Jun 2023 01:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXQfvi73HAoi9BA9xL4q/ISxkyXSDJ7Q1p7NXw2lrGvMxNo28N8ZW4nxpFAGzRCQ1NUB/77o0vNmb35uw7wUUcOHioFYN7+KrOnxUby+mapVgrzg0xgxQMKsUVuvO/rBBuRISHXnGCM5PUq+Tt2Hz5T7ZYs4YIMMIn4sijYtJEWuXZap4aawL3J5UtT+W9ryQWv4IDxvkWuhEF3UkTTqTFfTkGSC467hc0Q68tW8JmIS3+5Xi/P67Ha1aeNU6EgzAFSxfWKAh56mLNo9g1g51Ds4l7e96fEgvLfHR0xFXNKyrIdbEuZvqxs19IO6B+ehazyPAmhJYxMD5wuS1tO0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6a8TxWtitN3mua7x/weyiliAmigkQSPRyGDZ3W44sE=;
 b=biMcTgWm740cbUeExpHsehvX1T+5bUJ4pTjeFGoUV3MTBMX7vAC1belvweTcnrwcu+k1TMa2v1t8l9qqYDcZk2GmxcShqXNtBGCqFvFgtjSpvx55ZiKuX6pcFhQxX1SeYbYrR3cOMomZM/3ucb/kJ3i4VkPdqA106Aph/T4QeSvh+1kTAEvOvG2OaWHg1ENYSE0eFGEdbUFoprIuTASTODjSRmXhEHoydJSeLHToQ4ZwZV5AlDlspO9uRfVaF+jR+5eQB92hp5G6et3vFxb4ziiLUy2yO9ytdW9NnNMIMQki5yJhzzDVRwy5b4dnl66fsiBOUo0JZMtP5mvotCSgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6a8TxWtitN3mua7x/weyiliAmigkQSPRyGDZ3W44sE=;
 b=UqLpzdMJaMlHHMrth3NYryNeoKWnqNMqh09M80E5mbbSDJ+O9TvoY5JFnxACTaBeZiHfr/iBvP5k1u2x9XacMTrAubqA8e5HdDibgXknIbm5EazpRYGncDkZimSWdGX75MVTwTKRmS7ywbaKODsiX7GkXODiPoAj4P8QaadCQwn8LBmgn1ktSggTKL/zGn9pUrxzGjD+6yHIh4Nyu8YZeQP1I2M+xOUUWIMPcY3tJhDM7ofu8WFrMxETlHPd+2T7d/d0NIMbdUDm2Roie+29efJ9TFP8C9Rha5LpNZ3NdmQrKb66a8GtlBRVdBBHNqixcr4j5YUZvq29fqTjInzSQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Tue, 13 Jun
 2023 08:10:41 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 08:10:41 +0000
Message-ID: <ff5bcfe0-a2c7-c987-b19a-e50dd2c8b6f8@suse.com>
Date:   Tue, 13 Jun 2023 16:10:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: verify data checksum during
 _check_btrfs_filesystem()
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <61bb187a554ff0397665a8898ca2bd56419b6944.1686640441.git.wqu@suse.com>
In-Reply-To: <61bb187a554ff0397665a8898ca2bd56419b6944.1686640441.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a59f7f-6f03-49e9-2084-08db6be5adca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0A7dKujc2Y/eETgXvXbkqNhAIsp9KAQnDFQKUpfux9fVKewur4uJogSrV5jjpgj1ABgeboISYJ9KHtbU0QYKplmomR8hpJ27Ci1MjqpQrg2/brUPcs/reR07Al0RRY8xs2KbjkLWvDM7p4qe3ndW8NeSE297zRrAomPDPd1e7fAcNd+AMYL4nboT8N3Ve83kdfeTq5eCxWViDZPIKOyK4eRkQYZDT2p04ePP8i1kYFsLQJ+i3PHzyqMF10PJSq4fA+5VaRpSoaZR8TDCahWF7+sVeM7TEeGeOI3Po4wloyZfE8gs1tfkrkDNHOOljO+rPQBh7yO0DkKyRgT87724H76p+ktO14tqEVC/TNoWTupREt9DE+dZ7RZSQar/HVOJ7iG1NFsUBVJqcQyFek0ujlcAM4w7GyIRZ5ymnAv3MzBIzgSTSW94ts3tp0qyouaFIbTGAcvaO4GK+x2HhvG6iwurUOih7NzF8Hc50hcQnlQ9OLtjRhKcZQpBsuxoTR9qQr+vGG1zW4jodx0COah+TtUBWBS5rve4afctVDt7qHE7P5xY5HEK4gk/Emx+WxP09+KFKOUHW87w6sb9vhHD63lExs6gFsQHmegt8hgAdPMNjJtWeX531CwEUk1FWPKHSaAPplhPB19TIp2RovL2Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(5660300002)(2616005)(6486002)(450100002)(66556008)(8936002)(8676002)(41300700001)(478600001)(66476007)(66946007)(316002)(38100700002)(186003)(83380400001)(6666004)(6506007)(6512007)(53546011)(31696002)(86362001)(15650500001)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1BSeGlpWHpCZGZHdlVPWGVyUVVuNWRkZTY4RXJLeGxPM2ZMa2k3bGJWNXdH?=
 =?utf-8?B?eXBSeTB2VllNcWdpMllOSmFzSitNOC9obC85eEI1a1UwWEFHa2NiWStnTG0w?=
 =?utf-8?B?MzJ5Z1dKNFZnZnorYXcvQ2xaL2ZWcDVvTDNVK1JuQVd1QStIUDdqRGZueVV3?=
 =?utf-8?B?USt0ZDZYcUZtOFI2MmZlTjVrd2dyNHNCd3FaWXlISkVDQkxjelFmSGR0TnZO?=
 =?utf-8?B?MThvb09DcnJHMm9QTWtTN29tWFJwOTV2ZzdKRFU2OThlQkNKZnBCLzNDdno3?=
 =?utf-8?B?Q1VHK0pjVnlBV25xck1yeG1kYzE0UTdRTjJEVCtLcHdBQmpJczJxTmZoT1pU?=
 =?utf-8?B?R2RrbmhEaUdSMnhlN2x4Tzhwa2EyNzRZVzE4bzVxRVByNDNwc1NLYTJPTTU4?=
 =?utf-8?B?UEFBTXJTdFR6SlpDa1VwdG5EZnp2Y1NiQmsyYUZDeHJUVkhqSk9aTUd0UlNa?=
 =?utf-8?B?SjRCWHhvaitQRkpNMWdSbXQzNXJWWHBiWE5aZm9Ja2RGT0NwMmNwell2YWFM?=
 =?utf-8?B?bmxsSVZZT0hUem5HbUZtN3NvVUNROWx2anV6eE1WQ2V5VDdLVCtKaS96cHhF?=
 =?utf-8?B?ZTZ2SWJscWhVc2ExTUtDS3RmSG1ZL2IyQmJMcVRudVdGUUFxZ0ZTczkrajBj?=
 =?utf-8?B?MmZ2anNYUEI3UG1nSSt5VWtacVRiUEdPKzZVS0d6RExUZzdoaG9WWWthaUNj?=
 =?utf-8?B?YjdadnR1SjhBb3RxZWxVZTdUb3c1Sk5JMFVZejlqUk96MEZ1VktvUW1TbUsr?=
 =?utf-8?B?dEVSQlJjbEpxR2Z1WmFoWDlUVi9TaHo2WXk0UUxyemFXVVcvekZFVmNRTmJk?=
 =?utf-8?B?RkJmVCtXcmtUWlZYTW9ZZHNoRm1NU2J5K1MzYVlZRFpRLytKS0d1eUxjcC91?=
 =?utf-8?B?VXdaYXZiNi91eFZVdWVvSzFEN3U1Q0NYQmt0QndleFN4U1BXeWtpLzhmWHR0?=
 =?utf-8?B?RVV6M1NKaWdjNzVWdlM2cVhxZnpmYzRBU2hJcU8zcVhDeWFlbXRncmQrTTdK?=
 =?utf-8?B?VXZDR0J2eXZ1d2dFYzNQRjNLVWhqSUZ5VlY2SnBWcHNhMVhGUCthM1VTOWR3?=
 =?utf-8?B?em53S1Qzclg4YUkrNmpraXZpNWVMMDhMZXl6YkFvYmtnWU5ITFJoZXc2K2hR?=
 =?utf-8?B?OTN5Y280SWF2RlJCYXg4Ukw5aGtvS1l2M0taWHlYMnFTZUc0eFc4dmVUOExU?=
 =?utf-8?B?NlVrVGR4VUl4QXg5VERMQUxCVERES3dHRTg0RHpPellUbDRYaG9XZCtmbHRh?=
 =?utf-8?B?R1l3aGU5azRiWklsT3IwNE8yRVoycExOcDRGSUJ2b01LWmlNVWs3cXlVbkNI?=
 =?utf-8?B?MnNDb3BaczVzVEZKTjh1QVBDYVNXQmxwWDd6Q2NSZ1JXeDNvVk5lc1Z5SXg4?=
 =?utf-8?B?MC8rZXBSN2N6N3doMHhyMTREQTA5eFBRZ1ZUWDRCMEc3OWF1bmhES0pVSUJS?=
 =?utf-8?B?N2lrZHlSTVFiWTB3dkErVklrMkdSQ2t5dDhrL0s0cFhzUTQ0bUVpSlUzdVhH?=
 =?utf-8?B?T3EzMkN6OTYvdVFEd0ZQMUN4MVBROExnRDhxbmJ6emxGTzZBbWMxbEx3aWE5?=
 =?utf-8?B?WXFBWnUyaCtCYXZRT1diR3k3Ym4vaHp1TllueUFXdUNRVGlPM1R5MUsxZkVH?=
 =?utf-8?B?N24vVG00QUVFaWdvTmFEbmxia21nU1NlendSeWV2UWQ4aEhrMGdMeVYrangx?=
 =?utf-8?B?MTZHVE9RZXVURXo4OGdZTXZ0RElHWTIxNnZOblhQY0RqNUJKUGJBdjhwRmlP?=
 =?utf-8?B?RS9pdElZdDl0K05tMnB0TXU5clkrZFlDT0IwR2RQcFhnanQ1RGxZMXZqdlhI?=
 =?utf-8?B?ZElLWDFTd0Z5Q1Q3aDJQa1hOaVdOd3pNVDJqVDBsd2pFMjdNYWpZQzh5Znpt?=
 =?utf-8?B?Y2srVmhHZm5LNW85QnJkdTBLaDV6dCt5S0txaUdLVlJBcXVUbkZnWEZsTTJS?=
 =?utf-8?B?TU84SkY2ZkZSeU1vSitMVjRGR3hoOUd5N0FuLzM4WG1JL1R2djZyYVY0emtP?=
 =?utf-8?B?NzdqZFkzckhqOGVWYzJRaGYwZGlVaDVyNWhweCt3K2ZQWUsxa2NoUFpYUnVG?=
 =?utf-8?B?MzExMjg2N0lZYVRSMCtEK3pINW5vaStlSmd0cksrUkVhVW5zZzh3c1hJUHJN?=
 =?utf-8?Q?vyGWySz5Gd16zYY5tyqrjLphj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a59f7f-6f03-49e9-2084-08db6be5adca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:10:41.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWd7ReBUYc0md395AdK6rTgB1fM1PDkVkIHrnh5LklYWCasDvMSO9OrMWMQG7jlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 15:14, Qu Wenruo wrote:
> By default btrfs only checks the metadata consistency, but sometimes if
> we have some corruption in data while the test case doesn't utilize
> scrub to verify, or there is some bugs in scrub itself, we will not
> detect those problems.
> 
> So here we do one step further by utilizing --check-data-csum option, so
> that if there is some data corruption, we can detect them early.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is a little overkilled, for example btrfs/215 intentionally corrupt 
some data for testing, thus this would cause false alerts.

I'll try to find a way to append options so that test cases can 
determine if they want checksum verification case by case.

Thanks,
Qu
> ---
>   common/btrfs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index bd4dc31fa5a8..be8ac04cd9a3 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -144,7 +144,7 @@ _check_btrfs_filesystem()
>   		rm -f $tmp.qgroup_report
>   	fi
>   
> -	$BTRFS_UTIL_PROG check $device >$tmp.fsck 2>&1
> +	$BTRFS_UTIL_PROG check --check-data-csum $device >$tmp.fsck 2>&1
>   	if [ $? -ne 0 ]; then
>   		_log_err "_check_btrfs_filesystem: filesystem on $device is inconsistent"
>   		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
