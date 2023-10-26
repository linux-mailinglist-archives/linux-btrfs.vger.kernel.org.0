Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D437D8AC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbjJZVo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Oct 2023 17:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbjJZVoS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A34C1731;
        Thu, 26 Oct 2023 14:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKaNza+aT1iR2Vdf2dmdEOGAxeej+XtssfnATU+tRbLH/zB5AzN6QURTRNi4Bi1uSmjfVi/PO9XNfWzPMt8sqam5+Z+d5MYzZOTo4vvc0R/R7cEmz23DzFGyg8HCg1gR291Kg2kfe+ku2HAHP6JsE+fQFG5RfJhT1vQ8oeqGe/XHT37OXp1HefmiH3IwU0NPEN5xEqCuAzAI2aeCZ/i7GD5xJkUyrzM2DhY76DA7vcG7T6SXREEo2xX/zBYfxgxFLQfaJPMq45A3yaJglMtPhB32TyvOSuppNDjWlmDheGove8TqUz7O/aSgOPcIQdkLPbLkKrI+rx0tbU5u+KmIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH0oZ3ieM7Z3h7H08hzcgcDMbDaTBHyKSlEYz68rB20=;
 b=GFfwhTXQjVdRU9qGB9dqKfewtKmghAoXHmJ/2IySBz5L6B3o5Zt8qsIYcrIxyHMUglraqplYx8Y8ycpbb2T0g53K6l9jFDzq0QCsPYRbHVATfxtKsD7FOYedB5Nn74mxMNoA8BR0c9HgA+E0c80susksKlCaTrd35nNADUcmbuTh5il8tpHvVJ63kYt0yAHQQTR9QvqnwSmFRGWxeP1y39zPsrGkF9/irfvO9AEMqwMUjk+AUeXwMR2BgAQpGjqEp0dZhjnAYbs1NgWYrfhj4JI0LomxOUUrEzgeOLr5Z8wzlNKSnxNZwp+Xv4HMC7WyeXfIAeUmB9ixelIPGRW2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH0oZ3ieM7Z3h7H08hzcgcDMbDaTBHyKSlEYz68rB20=;
 b=c8PYqJdDvQMYhc+Jx/m3XA7mduqeAsuAV14QNB7j0XuwPfKZKOIm2UwvmvHqMYTdpAJm9iyccOygUMMVbt/yEosrRp3F6TKNqjAmVCxQeC8bEynHp1aqHh30bnJmOKq+2drXOQwiU3nqrk7w/QDdf0P37N8sSoBpMFSURW5el8cbEDBDJdTaEQjK2JBICKHLUmlXM4Jxa1bDrvYBwPF+vMomoskqZpTFgvrRw0mT3uxXIgQeL8KyNrGH6es8mE9N7o0hLnbNuY18acC4y/R6scBLgotJAnmILBiJHkWZzNfh+fqGxoa5gUIUG0WC3irJhN1CRvMYe9X12doBi15Dhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 26 Oct
 2023 21:44:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 21:44:02 +0000
Message-ID: <04b4f1f8-ce65-4acb-8025-5bf01fb77aaa@suse.com>
Date:   Fri, 27 Oct 2023 08:13:53 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
Content-Language: en-US
To:     Sam James <sam@gentoo.org>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        gregkh@linuxfoundation.org, dsterba@suse.com,
        patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <87fs1x1p93.fsf@gentoo.org>
 <02e8fca0-43bd-ad60-6aec-6bcc74d594ee@applied-asynchrony.com>
 <740c38b1-60eb-41da-93e0-7d7671f0b3fc@suse.com> <878r7paxys.fsf@gentoo.org>
From:   Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <878r7paxys.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWPR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:220:1df::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e319a70-8853-4092-bd04-08dbd66cab51
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUgWnPgYTxrOqQU2BVbKS/FTEa/+wsy2q7MZkMS9qdCsOzNVJa42AX7j39n48hrS50MvzjG+UZjcUWiV5HLXcA3ehfOUr6tM9Ii1bvQSYsnrlnXPf0m1K0gSDUIsyCUcd3XBv05YbuThVE5qme6TzN8FqBrY4ZGRYyueOtTL7K6NhJC4hLaYbMo3gbM+ZGCGa79bskvZZ0vHTjdP5mGWlVgChRqGt7YzCfTbgTxdr4EYSZe9DXGWRxv3iFK0mTw+JfQkoWvhf5jYHdWKXbs5vkf5+uB/CTGkhTvsk9l+7blDASSFjqxBI1CzlEjFUVQJk7i83vEZU0mkPft7j45vEExeSEj3z4MeWHxSpXx4zGY1qizSFTYrIzxEq+nAdNI408h+QvyU9ZGJIir9/p5oWpkc/We8zwbTj4Jid5Ljr4ilYLuj9WmtVRX3PXbUYNxsSklx4Nujvv74sw/XMwbTSiyyzI494HJomvYQrcgPwDhcupynDzbyMPgJECblk8cW591THT3sWmHcA5aeZ9H9kqtNzKFHR09rQPxeQyDv664wnr4ipHACFWerZ3/bPYSK4RBsKL9bWwPnJM5j6dGnloIgPfWxZHlT4sMOTJa2aUe0cDfQx035hhoj99qAmVpx2iDdE0Ax3exyCNnjFZnOYStpTQEKx+qQL42cyOm1ER8ntnGkX7PQ0u7upiTvX/7s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(41300700001)(6506007)(53546011)(31686004)(2616005)(478600001)(38100700002)(6512007)(6666004)(83380400001)(26005)(66574015)(5660300002)(4326008)(66946007)(8936002)(8676002)(316002)(4001150100001)(86362001)(2906002)(6916009)(66476007)(66556008)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVxTHdWSGtWMXFVUVNJME9ZNUFRNWU2cTRRcFpRV3RmblNta1duTzBhcGtK?=
 =?utf-8?B?TTlRMGFBZXhueHRhckE4d0ZYUHpha0NMWTlOQyszM3NNcThLeVp2bm5INzZn?=
 =?utf-8?B?NVhiSzVmU2toR3lEa1h6WnhmdldPZW1Nb2J0YmdMOWxLRXQwUlpTaVpZYVFz?=
 =?utf-8?B?MWNxTTRhTkNnU1kvUklKcFpQalcyeUQvaVJNQWxna2VNUVdCaURVbitJcXlo?=
 =?utf-8?B?d1lQRFVRclBmVkRmRk1LZ0g4djNBQmtJdlh0MHNsazRGRlpRdFVUT3phd3lt?=
 =?utf-8?B?TTlBR0tRc2R5MmZYWmdZZDRIenBCK1ROeXRnQUZYUEtQallBSE9KRlB6aFh5?=
 =?utf-8?B?d2ppMkNjd1pkUXhFMFVmTXNyT2FEZEJOcUVCeTh3WVpWVjdGWDAwdkhQa1dT?=
 =?utf-8?B?amdQYkYyVGY1anhFSTJPaDhHZVZ0dXNyMkVpNjVlWSt1MlRnblBLSmk3V3hj?=
 =?utf-8?B?RjRaaTE2bnNWMnZjd0RLVU9hT2pQbDdtK01qaEREY3p2dS9IQ2d2SW8rWGZp?=
 =?utf-8?B?VGFVajFwRlFvbEhqaVVyWW4vYk45OU5uRCtRaGNlcXRCWU9MV1BYbzlsUU5y?=
 =?utf-8?B?MlUwdnZRUFd1RG81Q0N5ZE91d01KK0hlVFBNeE85ak1iZEROTU5Pd2JJT0lJ?=
 =?utf-8?B?cWJFQWt1c3Q2eG9MRTlDOWpNOTdXbytqL25jQ1Q4SU1VVGtJc2k2Q3E4MXVq?=
 =?utf-8?B?QmxOaVhBRzY0UGQ5SHlBWnJIbXNVMzFzSFNKeVovZmRWcmgxSHBrdlZGVTUr?=
 =?utf-8?B?QnZTZTgxbkFjVWpKcWR2eWlvTUpKVnlPbDRqdVNRU0liM1AxQ0RUeGg2TmNH?=
 =?utf-8?B?T1ZaYVJOUzJ6QzRuc3ZGWjdwTkplOURuTG1PZkFHL0xjZ3ZXdndjcERveXBB?=
 =?utf-8?B?dGh1QklUNW5iWkhXNzhHWEZvbWttUzVQbS9JWERnSGlndFMwaExWRnpacUph?=
 =?utf-8?B?VFh6UktiOS9qVFJVWGNlYTVSOU14SHAzN1ovNFl3Vk1jc0VXbmt4ZGM1YjRI?=
 =?utf-8?B?b0M3S1dzdy82WWRESTZ0RUtyM09DeTJzTkZocVUzbVhBbG1sOE9hTkkxenU1?=
 =?utf-8?B?NVM4SzFnc0Q2T09WekdhVjVBZTlHZ2dtQlNpdFJkanpXTDVoZjdwWjBLNFR1?=
 =?utf-8?B?RWZBZGxCMzFMcm1ULzhhU3dFaFlUbFFwdUlxSWdaM1U4V1NQaXFibStlWmZV?=
 =?utf-8?B?dlZJd3lhSG1tdkZMZDNqaStkMUd6OFJnbXpVeDg2cEhTS2RUbVZoYU5zbU51?=
 =?utf-8?B?ejdZQUtNdjNKWkpKM01uUmczdjNWS2RnQVh1dURQUExEa3dyV1VQc2JveWdu?=
 =?utf-8?B?Tkd3d3UrQ3p0VTRhdjlrbEc1YU5MUDBMR212M2RIT1JFNXdUYm9LbXF6YnZ3?=
 =?utf-8?B?N2hXS01kbThyZzltMkF1L3pNOVZ3ZnVsSU5kakNhU1lodTZjWVdLbUJ6Risv?=
 =?utf-8?B?M0JFdWkwTHhnTzEyU2N5RUFxVU1aRHFsWThOLzFueTB0elAwazJoS1FBcG1X?=
 =?utf-8?B?eVYvQmdKbkxoZ2h0UW5INzBqbDNYY1MwY2dCNVoxT2FmQ2NJUUxVQVB6Ykcy?=
 =?utf-8?B?MFcrWCtrNm5xVUNBeW40WDZKNTBzckQrTWd0eHBSK0NZNjVUd0tKU29YbytX?=
 =?utf-8?B?QlF1WUxwRTEzRDExeVlnYk15Yit4NmNzVzNtQTVzMUhMbkZhNTVPOU1TUHln?=
 =?utf-8?B?S0V3cWI5R04xRE9QalNPejBFemxTVGJJRmtxMnNsL3VMdUNzdjVnZnIxdzVF?=
 =?utf-8?B?anJZUTc2M1F3cVIwUVRGeEM0ck80MXoySlg5bGFjS015WnJHZlR5SjVnWE41?=
 =?utf-8?B?NFRzK2lOcHhscWVNNUNIUTdzWElIQm1wYTRPU2dmRkdoU0ZQZlB6UFpOa2tm?=
 =?utf-8?B?QUJDdGZjQ2hOMnZXMW9yc3JOL2JPdGN0VzJPNm5mY3ROdS9IczZXSlV1NGFz?=
 =?utf-8?B?YVJCRnErZ09ZWUo1cUZYdnlBUGxKUnc4QkgrRktjQ2V3TWFjaXZyd29XUjBr?=
 =?utf-8?B?bnZ1MEM1MUFrN2JONWdQYnZjejRpSkllWkFEOU9ISzNPOXNFUGY1QmVOL212?=
 =?utf-8?B?a3R0ZUxhT3A5Y04xNXdlT1c5L1pQZGFxZURaSDhBL2hwajhKdER6bFc4VlBE?=
 =?utf-8?Q?DiUg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e319a70-8853-4092-bd04-08dbd66cab51
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 21:44:02.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLzsMOisfaa0OKtyXJgo/gIckVV7L/7+kP79OHMfNnY7bqx68PcoDm+Y2Ymt+FCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/27 07:42, Sam James wrote:
> 
> Qu Wenruo <wqu@suse.com> writes:
> 
>> On 2023/10/27 00:30, Holger Hoffstätte wrote:
>>> On 2023-10-26 15:31, Sam James wrote:
>>>> 'btrfs: scrub: fix grouping of read IO' seems to intorduce a
>>>> -Wmaybe-uninitialized warning (which becomes fatal with the kernel's
>>>> passed -Werror=...) with 6.5.9:
>>>>
>>>> ```
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29:
>>>> error: ‘found_logical’ may be used uninitialized
>>>> [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
>>>>    2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
>>>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
>>>>    2040 |                 u64 found_logical;
>>>>         |                     ^~~~~~~~~~~~~
>>>> ```
>>> Good find! found_logical is passed by reference to
>>> queue_scrub_stripe(..) (inlined)
>>> where it is used without ever being set:
>>> ...
>>>       /* Either >0 as no more extents or <0 for error. */
>>>       if (ret)
>>>           return ret;
>>>       if (found_logical_ret)
>>>           *found_logical_ret = stripe->logical;
>>>       sctx->cur_stripe++;
>>> ...
>>> Something is missing here, and somehow I don't think it's just the
>>> top-level
>>> initialisation of found_logical.
>>
>> This looks like a false alert for me.
>>
>> @found_logical is intentionally uninitialized to catch any
>> uninitialized usage by compiler.
>>
> 
> I feel like this sort of thing is going to be inevitable with -Wmaybe-uninitialized.

Indeed, it can be tricky for compilers to handle.

But it's not that frequent, thus the btrfs community is mostly fine to 
handle those reports manually.

> 
>> It would be set by queue_scrub_stripe() when there is any stripe found.
>>
>> If there is no stripe found, queue_scrub_stripe() would return >0,
>> then we know there is no more extent and break the loop.
>> If there is any error, we error out too, thus no problem with that.
>>
>> So to me this looks like a false alert.
>>
>> Mind to share the compiler and its version?
>>
> 
> Sure, GCC 14.0.0 20231022 (experimental). Sorry, I'd meant to include
> that in the original post..

Wow, the first time I can not catch up on the toolchain version...

And considering it's still experimental, I'd say if we got another 
report on this particular call site, we may consider add a fix for it, 
by simply initializing @found_logical to zero.

Thanks,
Qu
> 
>> Thanks,
>> Qu
>>> -h
> 
