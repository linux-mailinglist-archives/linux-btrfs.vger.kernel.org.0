Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123EA7A8FB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 01:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjITXEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 19:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjITXEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 19:04:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5949118
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 16:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVDX1gMQqe5rYSNL1dEQPv7wMeAjDnpevHzUI1SMQTk5DljcdsuyP1EESYWYwQlTHqmwBLmXhFPC5f6hCnj7iGDYRj7NQQyeJ1zVo/qaoaKsmxc+74vPin2JzbyX+jWEVx7FKbTBp1A+kn3kFoKnkn41KhX1g2hKZiOqJ5RZA72UJgDtpeHzzutT9qACd/hm0lJ1e1NMZlNz1X1735sL7915XDZ20OOT45Fy0+hictMBUzaoJB76Ore5eN4SmpnrOCswBTNDvxp1ubIPpNiGxHMWUVopv/LMfcLwQ/HRV9VNSHbBOoH5gHwa4FRwGEtqpar4SzY4CEjCemsIhwqODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46YGISSbGQAfFJOiUriHLUEQiUwdj7Q7/Sq52jzucUY=;
 b=no65Wy5YODf3xtxXnAixNvTeWZu+B/MIyrGcYH6bh8KvAp8bvAlz/0e/xDhmyBnjo8qMkIj5JcosyJa49cbnNhHrmZ3vFVNc0yTmeo6wonyedRfBUgRQ6sLvE7y8pf1vE6cvzdPi2G/TkTbH/fc9BlcOW44XmxtuX5S4ZkVuKZwRs+ojEe5hYz6W7lsaNPq8mBNmN9v2qWJyqWWYaoAeiGoWV6PiPKibdARCrk5Q733pnjSIvqBXkiOLAqux8Bi+woqPsI9mK+5nlrzWUINeDM1yrHeVIUl9y1TRBKQhJ6YbhP6q1rjtwa3g3lPd0ITFu75ip+Gxq4UJ4ix+JtaJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46YGISSbGQAfFJOiUriHLUEQiUwdj7Q7/Sq52jzucUY=;
 b=Pq7MLY+pDFbBAdW2W5JktFbYCrS2ZmUuwFqSptLgdpSB84O7XnQrynmOiWayzmOa9eqelmnXolSyfzzugydlCERvrWdxlPcWedc2I1jB7WAtXvPpv2fWR2WQk3I8Mw3byVpccnHRt4IrJIe3vIje6BUV6mg/2gs7PKnHKPN25q1GcG4rESmcWjAQsEgpEQoEA6r3JB+110Tl2dYRimiUE8pPh1byVaqk24LJ48NQnEEy85g8QKi8fn9ryGWDGvG8zufw0KOvG0VMnVDaUBywjf43cMIQCsET2UhanY9kwb2uBF24MlZCtT0Pc7uNd/+Utz3UzcbQSQMV9dwAKpivnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB9916.eurprd04.prod.outlook.com (2603:10a6:10:4ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 23:04:11 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 23:04:11 +0000
Message-ID: <e31f4562-9acf-4650-87f7-19174e581557@suse.com>
Date:   Thu, 21 Sep 2023 08:33:54 +0930
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <cover.1693900169.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cover.1693900169.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0274.ausprd01.prod.outlook.com
 (2603:10c6:220:1f1::14) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c73942f-b3cc-4676-a628-08dbba2de708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cW9/Vb5AgQF6Bfvv6s6N7gFp30KYt4LD7kmkaG0qUMjsH5qFYfUSjjH7XI+zGnOESFdc/xkVvjU9zfLkb05qkBlMVc58ZElhVzMe9a/kaNWZHOLCbp1gXAKFlbKXLBLeaT3lOd9zt5/Cxg/2gMQbEJv8Y/rwGjp3if80D5NqF9RylCJWst9zdxCt/CWDODqiP6PU/Xo3KoSOJtOmJO8mOPKGsbzRwOre6v3Z1TpNXQSosM2lBVEtJjPdzHZ2XXE+7zaEVxQAlJeUTDSmuQtMOq54zkeBFKd1qqYhs7QMQS1kOlFmQcZm0O0KgBa69HIgtOg89XM2S++ZIIhqgrkJWMrE5CkqHHlHig+ZcWI5UUhoWSHbmYHN/nDZ3M9z0q5ga0F0OOPsUcNCeCgb9tjlyPnC7V2ql0Ly75nOS/KHYTwN2fjTEbbCk6xjmN+SxMIL7solP4P4geyVR8DfJxb6CScUlGi8+pHeCeAgYpI+hGVD02c1yi7uatrU7jbj44vBe8giMlpYMZdbPqxVibkK/M8sdyqDF6+/mOD07vWSXNOKPbg41paVBTSbwxRPT1LlkpKZrTj7Pzpa/FdXhmgUJR67n9BnVP/7DIHCiww/CuL7KxAMnqkJAII+Fcd4DVFrmhbi9/6WZOGUmfpMqsw5VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(1800799009)(451199024)(186009)(53546011)(6666004)(6486002)(6506007)(478600001)(6512007)(83380400001)(2616005)(2906002)(26005)(66556008)(8676002)(66476007)(66946007)(316002)(6916009)(41300700001)(8936002)(5660300002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1kc0JyLzMyai8xZzM1M0gyS2hvRGRWWXN1V3F3K2hOdllXK3V3YzNKSURW?=
 =?utf-8?B?NlVrU2FkWEtROGRlZENweXk1TFpmRDBCZHZFY0V5a0RsNXYrMHBhZi9zMEFq?=
 =?utf-8?B?NEtDdUJoV3gvYVFYb003WTk4aVQ5ZU1aMmdYOWpWdDhTaU5oWTNTSkY1c3R6?=
 =?utf-8?B?MkszWkJiWVVaZ2N1b2ZuTWtSQ3ZZSGNSQys4L0VhVDNUVWxER2F2eGxQNkgz?=
 =?utf-8?B?d1V2T3BoUUswZHBTWkFJTGhjUE1zdjFHc21TeHhWSjQ3VU1lQXVoN201aWRh?=
 =?utf-8?B?QmNvOUd4QkNWTGxFd0pxNlRQZTRVSDYwUDVreWc1M1FweVJ2enV1WEcvUS84?=
 =?utf-8?B?TWo3aW82MjU5NDFmSFBOc0JHRkVIb3Rmdk5DU0Q3aC92UzNQaWNTK1ZyVzA3?=
 =?utf-8?B?U0VsbjlxRkhkUEZvdzNVdGZSdkJQRE5GOXJVYldwbWJRVXMvUE9oZnVLOFB3?=
 =?utf-8?B?U3hPTGpVSTZuZU1TYXpoS2JLdlRqWTJmSm5JeVgvdXVKT2NPWHA2d2xBMlVq?=
 =?utf-8?B?K0tSUXpJVk5FUzYxemYwVDd0SmhCSTM1OEt4M3dmN3FwdUlqMGU0ZWZGR3Rn?=
 =?utf-8?B?a1hXTTdoTVZHZ1Urcm5aUTRSM2ZqVVFRSUdUbXhlTFdTbE1zQy9GS0NWMHlL?=
 =?utf-8?B?M09nRlo4eklrNnpocnpoMjgydFNtZHplK1RLKzhYRWhjWGpKd2ZnVFJhQnB5?=
 =?utf-8?B?Vk5hWEJNRnd6c2dJWWRrbVFkc3VSdXVCZnhtR0c0RVU2MDNtdkxWWGJyZFJx?=
 =?utf-8?B?bm43NmJiV25oQVRtTU5qTG82aVBuclRSYlhHNTU1MTVoTWMzK3hyZFRRTGNR?=
 =?utf-8?B?dWs5dHErM2M3MkNaVit0aFRJVVFGN1RGeDVBU0k5bHE2T2Q4c0RyRkJPTmlw?=
 =?utf-8?B?cm9CcHY0V2JKWVlFalJ2QVJ3TzNKa2NHL1lsTFh1WjBHaFptVWJTNFY4emNH?=
 =?utf-8?B?QVo2ZWdRS001cWZFT2Y4Uml0Q3hRTzlmK25hOE9oK0hFOXJkSVlyT2lpa3kv?=
 =?utf-8?B?UU41YXIrRGdQVGxLZFUvQmVrL2s3M0pVaHBSNklvc29WOHBUWXNVQ0R2dkdn?=
 =?utf-8?B?cDExT3JoVHRjU2llWiszdVp5WEs2N2hIY0s4K0RrcnkvaGpSTVJVcmRtdE9v?=
 =?utf-8?B?enFDUFFXbi83cHV2OWczR0R6dTNYV3pRVGtENmpTMjlsRkU2eE5Ga2pZdjh0?=
 =?utf-8?B?UWpYdnFaaTB5NlVoaTR0QkJ3QjNXbUJab1B4WmhWSGpRMll5TktSMUk5Q29S?=
 =?utf-8?B?SE5hS0Zqakw5Ni91cXpZZ1lVd3lMZ1FuV0FPWjZyb2M1Z3JseFk3dk1rUm8v?=
 =?utf-8?B?WXVJYlp0QXVjQlBiSkIzbEVtSjhTYXUxSkNKMzNNQUxQbmwwZHNiRmtvMXBQ?=
 =?utf-8?B?a0tpOXVmMnVjeUNod25zeXZrczhjSEEvd09qcUhnN1U5WmluTWtDWDhWSk9z?=
 =?utf-8?B?UVIxMW1CcHozbkxpT0dSVEN1ZkR6ZFEwS3lJQzhEUkY4YmRnQm9pREdJSGIv?=
 =?utf-8?B?WmhSc0x1THM2VW5wZklmR3AyMC9UV0FXWW9mM0NzTEtoQldKajdyTzdyVmNJ?=
 =?utf-8?B?dWJ2SUhFcHQyL2pVTlJBT1BjT0NleWl5WFdWUjEybm1oZEFJZkdHMmVlNUxu?=
 =?utf-8?B?WlY3L3E2RmZtVnJuTHYvVmI5MVlkVkowVUlkKzV1enZMc2hvVTh4Y1pWY1pU?=
 =?utf-8?B?bFlrMGJONHJSTnN4VURNZkdxdVdxVWl5MHlOMHlUZHFCbko1dm9EY3pQMEZ3?=
 =?utf-8?B?RUdwUCtiblZ1U2FXR1ZtTFk5M0FXQkpRM2xVQWRWbm5BU0Z1WWRoSkhoTEpt?=
 =?utf-8?B?UFFYSHgzcjlla2MvYVZjWkhsaE0xRUgreklEcjQ5aU5qcFUrMzU4bTRyQ2Rj?=
 =?utf-8?B?Ui8zWjRTSzlWRnVhUndINFphYmRsYmk4NnlnNml0MHNuMmE5RHUxdjNMQ1Bk?=
 =?utf-8?B?NnJ2RnFjeXVNbnhHRjBlK3BhSHZGZnlEOVB1dmpTVENzMTNza0V4Z3poSGRp?=
 =?utf-8?B?TWVtdUFGTXZDeGF5cS9vcHlZUHBJQnl6bXlILzAvZGpVUEJPYThNZ0FmZS9j?=
 =?utf-8?B?Z2dYaU96Z0tYZzVOZXVXU3BGc2tXSW9ZcjhKSG5kcnVmdUtYYnQ2YnRSZDFT?=
 =?utf-8?Q?lxB4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c73942f-b3cc-4676-a628-08dbba2de708
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 23:04:11.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPdxp7swFraIbwjXPHNphQEJ3aMQyjDJ164247ZwRXZSGFLmFj9+LrvSfNl7cDsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Mind to give some feedback on this?
As this is the basis for all later "btrfs tune" subcommand.

Thanks,
Qu

On 2023/9/5 17:21, Qu Wenruo wrote:
> This is the first step to convert btrfstune functionality to "btrfs
> tune" subcommand group.
> 
> For now only binary features, aka set and clear, is supported,
> thus uuid and csum change is not yet implemented.
> (Both need their own subcommand groups other than set/clear groups)
> 
> And even for set/clear, there is some changes to btrfstune:
> 
> - Merge seed feature into set/clear
>    To enable seeding, just go "btrfs tune set seed <device>".
> 
> - All supported features can be checked by "list-all" feature
>    Please note that, "btrfs tune set list-all" and
>    "btrfs tune clear list-all" will have different output.
> 
>    The reason is some fundamental features like no-holes can not be
>    disabled.
> 
> 
> Qu Wenruo (7):
>    btrfs-progs: export btrfs_feature structure
>    btrfs-progs: cmds: add "btrfs tune set" subcommand group
>    btrfs-progs: cmds/tune: add set support for free-space-tree feature
>    btrfs-progs: cmds/tune: add set support for block-group-tree feature
>    btrfs-progs: cmds/tune: add set support for seeding device
>    btrfs-progs: cmds/tune: add "btrfs tune clear" subcommand
>    btrfs-progs: tests/cli: add a test case for "btrfs tune" subcommand
> 
>   Documentation/btrfs-tune.rst           |  47 +++
>   Documentation/btrfs.rst                |   5 +
>   Documentation/conf.py                  |   1 +
>   Documentation/man-index.rst            |   1 +
>   Makefile                               |   4 +-
>   btrfs.c                                |   1 +
>   cmds/commands.h                        |   1 +
>   cmds/tune.c                            | 448 +++++++++++++++++++++++++
>   common/fsfeatures.c                    |  53 ---
>   common/fsfeatures.h                    |  50 +++
>   tests/cli-tests/018-btrfs-tune/test.sh |  40 +++
>   11 files changed, 596 insertions(+), 55 deletions(-)
>   create mode 100644 Documentation/btrfs-tune.rst
>   create mode 100644 cmds/tune.c
>   create mode 100755 tests/cli-tests/018-btrfs-tune/test.sh
> 
> --
> 2.42.0
> 
