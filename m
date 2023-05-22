Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DFE70B942
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjEVJmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjEVJm0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 05:42:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E5E0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 02:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpJxc16z8n6umgepMUmeLtQ8La+S5TPRdwksRno0/xrvBm9qUcLwVYPAuYOXClGhzREdaJSHqjoEY3rpuG6NzaOhHnZceB9SFZL80ChgxECgyv6AowWHjRrWy2MwE2BB6Pg2NUus+BqE4ekLnZg/oHTD3aQ4+EjgCYFTIL0ZpPOt8dElNNwT11vgoqkXu/UgbCg4B8vY9WJyi26hBwyW6XnQesE2xM1qf1a7shXBNIBBRVG9D6L90/UNRxEBwsq45C2M6ZRcpFhcMlX0nEkMsZxD53/YXIu9SRF0Pv+GJz81tAoUZkhuxOcBXhEnZTqkYDjMb/m1B+Yo9XNEL31cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+MytarVo0hUTuutU70ld4csFnCfy8S9gyDCA7HTPRg=;
 b=j0ge4vEquXWF6bLNn/2KUgKh2puoR3MmCbKNsX58Ti8MKc1yVRJQw3gOp9HTBx3xQ5K/UTVv2i5fBlsS0YEzoXmwz9oi8/+9RuPVE87nwhl9VPv8oCIy70vlq8fhc/QrV/DE5zRoj+jfOfaJJeMUZAuf3RFx/Onq2RXRpcRAJQjYnMdCLQrNIxvFkiJy6btl83K9/bK+d5lgLkBl+mhCsBf0mFe0hb7Z2/aCWf3c/ukdmcK7fVF1c7DA2g6i/nokroiYioyEfnvsf/XDn5AeRh1U1RMEfr2UhRLDGSP1xpcD/O8ckVW+5YO9Txec3aLpl4MHSCWm3gxMYEPHMrv6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+MytarVo0hUTuutU70ld4csFnCfy8S9gyDCA7HTPRg=;
 b=EO2TdDGNA0GVpr4rcl+yOXqiDqzClL5yuH/FoPdDCkq8hGq5I23UoSrl+qk0XPt9c7N3G9aJSAZojU7wrDl75g2sxVK+Tyo4x+lMysDxrXyt8is3KmH1b4jjbbxs72p/js0O/0uv1OSJjwJh/RR4k9aMI7QUlSxE0ZVpVBowB5s4h8yFGswwDTwpAM8JHw8liFDGNm7pK1axon3D2s5YHR6fd+KZ3HTAY/1/X7hzIQRSQj3haX4nfsT8onC/bYBq8H5DddnuCrHYFp2VaEYR6NH6O+QDpAHzyj+n19tuKjKfNEif5l+OiNqraLc7XBj8JT8tFjgnfbdI/njSQledOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:42:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:42:15 +0000
Message-ID: <77a11ab2-f5ef-0476-2836-82a52db88f27@suse.com>
Date:   Mon, 22 May 2023 17:41:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] global: Use proper project name U-Boot
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
        git@xilinx.com, Tom Rini <trini@konsulko.com>
Cc:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Holger Brunck <holger.brunck@hitachienergy.com>,
        Igor Opaniuk <igor.opaniuk@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        =?UTF-8?Q?Javier_Mart=c3=adnez_Canillas?= <javier@dowhile0.org>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Kamil Lulko <kamil.lulko@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Lukasz Majewski <lukma@denx.de>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Matthias Winker <matthias.winker@de.bosch.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Walle <michael@walle.cc>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Philip Oberfichtner <pro@denx.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?Q?Pierre-Cl=c3=a9ment_Tosi?= <ptosi@google.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Ramon Fried <rfried.dev@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Roger Knecht <rknecht@pm.me>,
        Sean Anderson <seanga2@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Simon Glass <sjg@chromium.org>,
        Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
        Uri Mashiach <uri.mashiach@compulab.co.il>,
        Vikas Manocha <vikas.manocha@st.com>,
        Will Deacon <willdeacon@google.com>,
        linux-btrfs@vger.kernel.org, u-boot-amlogic@groups.io,
        uboot-snps-arc@synopsys.com,
        uboot-stm32@st-md-mailman.stormreply.com
References: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fda68d-d071-4968-5102-08db5aa8d34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GHxFOUtQcUunuYtu+bDiwIvS+2QYPgJ0I3Z9VTkwoFiGGv6KUjFYgHT16HydhNVBib8dejhworKfPleGUNFK6dPwIcfYAZRUTW+0YygORJ2sYW76LHWExfE3J1IOKjMqfxeLUGSkKPQvv1Pvm7P7q3+48p5YICTYni+o02k9+fJ/fqWLaHNzbJtUAMMO8eTozoLlJ0OSlZijLagddNhYj0UgFIXxljubPjIPsCHsKlTK05NZfK5qbqi3+N5wsD3oEXjTnBLfoBPo0cAPvDobcIUCbhsze7vwtZSvV3PRq/Cn+HswRK42pQT/xKQBeztNG2LeQh1mskX2EJz1WCYAgfU2ekZAwwheHpdP8UOscPk67a0GTakZNQ3CX5cHynVpT0PJP6Dkm1mCsMr8lgQRZh+apBqB1LE4PDR5wJpzMIfEQdJuix6jHpUiMv1MLDuXeam+fz5IWW5d7B9aPJV5CoY4K2CL50VXwFJ5GNMoJkQiBBet0WQkw8Iwkr2mxni5hitxLt6eY9nl3y1/moRZLZ+vyNY/LQ/4PZH80dXUgIUYmPp90Wk3mAaYMJ+lkFGwUq6zu0lEjJrCQbmtOArdGtPg3f5WH2X3SuLIsfkbHPB9GHd+Jivz36pzhZb7qKSXdS8sWOL2MIWQoZUuNDfZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(478600001)(31686004)(54906003)(110136005)(66476007)(5660300002)(41300700001)(6666004)(6486002)(186003)(316002)(4326008)(6512007)(6506007)(7366002)(7406005)(7416002)(8936002)(8676002)(53546011)(2906002)(2616005)(66946007)(66556008)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NsdDAxVWY1elZlU0RCbEgyYkF3dHZtTm11UzVhOUJFRStvQWhTalNZdTNy?=
 =?utf-8?B?RGdJcTVrc0cydUVkYnZySFpFd0JaZWxidU5WVDZHQWl4M01iVW5ZT2p4b21R?=
 =?utf-8?B?V2lmaUdGeU44ZS9VOStEeis4bk5maStOdWxkMjV5cXBCayt3aU1oQkpqUmlE?=
 =?utf-8?B?TW9ya0d2dkw3UW5QaEg3NEM0M21xNnhIM2tVbGJBbUgvWklwTDRxclNFNndM?=
 =?utf-8?B?VFJkOGhwTGR5UmpPYlF2NU85V3lxZUpaTlpHMzUyamt4cnVodE1iajBHTWp0?=
 =?utf-8?B?bDRwam5FQjI4Z095UWVzcFhDVkd0MThOQ2g0SXJQc0Q2RVpLWnU0ZFRhQ1Jv?=
 =?utf-8?B?akplbkExeEJxNGZuQ2xTZHcyVStKTVRka24rZzFXNVJGdXkxRVp5Q1F5NVJv?=
 =?utf-8?B?aHVPRDFsc3poWUJoOWVMbU1OcjNQNVBqUlcxNWRvVzBMOStpOE5aNHN2RzdR?=
 =?utf-8?B?WG5tYmx2aW02dE9rY3VhMEJhcTc0Unl1aExDSzZPdmE1b1NKRU1pZ0l0Q2s3?=
 =?utf-8?B?SlZjbGJWaEp2clVsYU53OUs0TlBXaFR5V2JyQVVjVmlwSmxsOG03MWtoSkpL?=
 =?utf-8?B?VitoQTRYbWF2bDNvKzBuNk9hdDgvckJ5SEp6VmFzb1RuNDIwT0hrN0F2WWt4?=
 =?utf-8?B?eDR4YXYvYjFKamxQMzY2TEo5c3UyYlZXL0J2UHZ1WndBVmkrbU9FQzNzWXpS?=
 =?utf-8?B?a08vZkdPL3AxaEZoS3VvVGo2ZG9GNm5Yd2JWTEp0U0xQMnJ3c3ZOR1l0dmNK?=
 =?utf-8?B?MlBBczBsUG9wL0pNdWxaSVA1RzhDd2grZXNWV0tRUnhGYWtHZFlEZkZZMU56?=
 =?utf-8?B?NytVbGtwNG9PWDkxUkxYNDFnenNpZm04bFpDeWo5R3JkbFc3blVJeVU1aW1a?=
 =?utf-8?B?VzdXV28waHcrdnU1d25weC93UnpBb01nZUZtRXRQNHN6RlJSWXprT3dVSmtL?=
 =?utf-8?B?RE5yeDhXOTAzZUF3alFJVnMxVVlydUY0K2pzczRtZ3U0amtieldiamJzQnUz?=
 =?utf-8?B?dEJCQW94d2xPWFNlYUJseTFjZkVwUVJxM3JhN0VYamZQdEJMczVPdGpoeXdB?=
 =?utf-8?B?RFU3ZWtOQW5meGd3eEdTYW0yUjNjWFJDZ1o5UEtzTHpNR3Z5T1ZkYWpTbTZN?=
 =?utf-8?B?WGxLRFRBQ3VjTkFCME5ZZGYvb0xFcXphVXhWZlg3TjhNUzhqQXhnc1pVN2tl?=
 =?utf-8?B?bVR5L1d0VmRNb2hFVDcrMWMwNXI3c3VMbzRWRnE5dzBwWE1HeEpJbmh1WVo1?=
 =?utf-8?B?UmU3VncydklYa1NFa2JycmpEL1BNMG9TQUFWdUF5SVJrZDNwbEZvMUxUS2Rk?=
 =?utf-8?B?OWNjWDExMGtkMnVKT3ZKWnVxYVltVTA3MSttbVNEYlZidUFwWE14UGZmOWF0?=
 =?utf-8?B?WEo0V1gyZUtrTHRFT0JuaS9NQmFPNGxRUkV0K01Rc0lQWXp3bDh6OEVEK1Vt?=
 =?utf-8?B?S3c4NnA2QnBTekd4TGdoWGMya3BoUiswY2wxNWp6Rmwyd1hSN2J4MlQ5R3JF?=
 =?utf-8?B?VkxrcHp5SlVXUnp1eHVjSVBGd3NoQ2NvSktDdDFaT3lnVW1KTUhwUTBxVkZ4?=
 =?utf-8?B?RlcwdmZnVDZXVDNydm1yV1ZtWHFpekVCaWs3ZitJSU1EdmNiazRrbmpidnhD?=
 =?utf-8?B?S3I4QjR4bXNiUnF6SkVHTkxSOGRMMlRFaDJuNHludi9RWlpxNWczeTVOVGp3?=
 =?utf-8?B?T3dxb0Q3V2dkWFpMWjU5a2FaUWtGbEJ1MFN4Q3Q2OXVGS0VURDBuZXJZQmdX?=
 =?utf-8?B?Yi9MWnBrOUJLZWhZL01nNXBzeEMzVTlyL3dUTG9ERm1QYUxwUnhNMVEyRlFG?=
 =?utf-8?B?bkJ0MDdlaUw1cXFxSEM4c1RHcHRJU3E4WDJXL1dEak9HUjkwZm9KZWx5NDMy?=
 =?utf-8?B?S0pHUEpTWk1GekhrK1BXR2JyK0MxbktxOE1WdEhXWVhGbzkwWFZLWWFucGZD?=
 =?utf-8?B?clZ1TTVHN1E3RlY0Q0J2YUd3cm1NUzdCS1Zrby9hWDlMUFRZWVBlb3lEd2sx?=
 =?utf-8?B?TGNIM0lhMFkrdUNMaTZ4RGhIM3JCbjdkb2ZBb1lhcWIzZzl1VmZDTzcweWEv?=
 =?utf-8?B?alRBWlVtRlJaVlRTR2JLd1JxZElmUk1UTkZpS1FyNDE5aEZneWZzL3hnVENX?=
 =?utf-8?B?UzMwME9aRllNTW05enU2Mk1ObmZ4NUhRVjBGVDVRbTl5ak8xaUR6ZVdoYzhW?=
 =?utf-8?Q?iripcEqY54464l0+7eQUcbA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fda68d-d071-4968-5102-08db5aa8d34f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:42:15.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnF5U6XAeLg9AH+q+myvJuFcMzxqA2GhBz2SCNfkQTycY1CxYBqNPCslaBczNOyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/17 15:17, Michal Simek wrote:
> Use proper project name in comments, Kconfig, readmes.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
[...]
> diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
> index 9cf8a10c76c5..02173dea5f48 100644
> --- a/fs/btrfs/compat.h
> +++ b/fs/btrfs/compat.h
> @@ -46,7 +46,7 @@
>   /*
>    * Read data from device specified by @desc and @part
>    *
> - * U-boot equivalent of pread().
> + * U-Boot equivalent of pread().
>    *
>    * Return the bytes of data read.
>    * Return <0 for error.
> diff --git a/fs/btrfs/extent-io.h b/fs/btrfs/extent-io.h
> index 6b0c87da969d..5c5c579d1eaf 100644
> --- a/fs/btrfs/extent-io.h
> +++ b/fs/btrfs/extent-io.h
> @@ -8,7 +8,7 @@
>    *   Use pointer to provide better alignment.
>    * - Remove max_cache_size related interfaces
>    *   Includes free_extent_buffer_nocache()
> - *   As we don't cache eb in U-boot.
> + *   As we don't cache eb in U-Boot.
>    * - Include headers
>    *
>    * Write related functions are kept as we still need to modify dummy extent

For the btrfs part:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
