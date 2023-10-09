Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A747BEBC6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjJIUkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377954AbjJIUkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 16:40:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527AFA6
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 13:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK2WKFQOgsuopdG/nKXoll2/fLAH+jaMMh/mnvMUYl4FliRodSvJdTHw8gS5x0wwZpS47dq17K8X3n81lXeF6PoWnXJYGzqtxqBMPa2Uh69LjuaQPYTyifcIlRhojxbE/ds2wUbgUX5B8UIy+LaqWvcyX7E8GgZBBUeyN0D0MEHxrzF1nBhggyO4uSY8R4BqQbcoEYVjJcdfnN4eZHq8RpUyy/tTAk/6CvR5FyHWLEUzguRjfnaa/q2SOxDZQkuhJgizwUVReF/uXPu7vuQDmIJNLh/KXAsApFWNpxVTlc0y8X5Z1Ffhnh4J8ybuRmB3DUvEetfRbn30PZ93/A1MDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXl3Z0CcuKp2sBXayAYxgPQDV+sfo0hFgvAnLJlr1yc=;
 b=F5diPff3ce2SVgKnCQYr+W6xJZdfruVyphKPiRIM63IKUwu7sWMPD2q2EdzqVWC5z38cEgIpQO4hKZW+oTZBcE/ebF35gerFH7epIlIcMaKdOgRWfAwFfjq8qsGpmWvT9NVlfJSXnJTVpaTnnBoUXYScdCMOvzWgWgP9thgGADkJFhdNxEkkHRmKSpPNPnAZ57d60wdJ0Kt/sVSYJ2zladH6EyDz9btY5GfOxPeNXLGZ4sXixt4hFEs2Q6PEPOM1DULUfcwdMDdfzqcB791bPFbMfdVha4K61q1DL5AKtuSiI/zynkbb3fCzHG3L98ngfJdjBMSIgWTnniiRVrUoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXl3Z0CcuKp2sBXayAYxgPQDV+sfo0hFgvAnLJlr1yc=;
 b=zxFYSBRYYLfUL0ri92gGcqJ4r6mv6JjXze+aUouS76nBd1ko1+cBwTJeTWYRS5ZYFqAaQViEZNYJc06UxNG1CgVZjWrlfVkt1ttuoH8SpruxNoBUX2DM2aFAEjBb+HjJpxMULiuaK8kA8X7iIjBh9V+5NPR/fGhab5rkEj4G0PQTwTfUwjZJxuCqT+ap9I5gpA5MiQMT4z3La4oBtI6yiwGgmGjevgYjPEdcRf7V+UK6SFqlUavJq2LVitniUZSZqqBo4tuYdtgQVJwyGuPhAzducWxYExiDXBYEUf4TM332mQAV7zuPKtQQJSvTix2Ugx8o7tmt8aALCX+PYzJM2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 9 Oct
 2023 20:40:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 20:40:26 +0000
Message-ID: <0f07ab1e-6448-40c7-b54e-77c614f04c14@suse.com>
Date:   Tue, 10 Oct 2023 07:10:06 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs-progs: tests/mkfs: make sure rootdir got its
 xattr copied
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1696822345.git.wqu@suse.com>
 <3daf7ed97305f5482800e28c960e3b5c2ed222b3.1696822345.git.wqu@suse.com>
 <20231009135821.GO28758@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20231009135821.GO28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3PR01CA0015.ausprd01.prod.outlook.com
 (2603:10c6:220:19e::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 56deef81-7dbd-4b5e-9fba-08dbc907f77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJDc5quPRjgnIkVqMAyQKQRQlfENrMIUm+yceLhkAUHkWp+e20UXgS0Ef0aSqISI2TVkdl9g2wCdtVoG8sPUOEzt/EZbLTEHto+BS42yW8cPMwkGD2yT53UiAlD31qs4DNPcbvkPXNDGsRecjaWx5V1FZRdw0I0BsDIagcHnaAZm4d6C6r2jIm2NAgeZp5qnJMPyC+m+aEgxxio9rt1vPeSEUpnGmIk0Qe1XIHdlk+VOoL+y9EKZIiyhCqZoby3FYgxoGvR+PlxPaFncRvGwx0WLCkvRma41CZ5AlkxE1focC+woadKAQnJI5uP+fWUYBljd5uqGZkwcJOkCytlCLGYkiLCSzQZGaE7GOx64j1wnYQCQDqr4jh1DfkA+VM7WA7bsnIm/G2yYcJ4sv0pino/pt3K6aUOTdhWqdCDkgMzBJolqcwh5IN1T0zqL+K44sNR1Zvk4y7Mi8GD328GFArTbjzT2ZqKBEEo9uCdO5/LFZ6lCunosgDy4vRYzK5yyGkYcGHApSNN2z/pSRATm94eKaGd5gbSfcLc9Um0UStn5YkYiBwGUVDHCCXfQcey4HLgj6SCtjyA1FjK5u43EwfZzSAXyQovU5Xtc+0/6l87pf9kAPHcsw4ESxm/lvawfShAq5Vh/WGjlZADeq7E5tD+EQLH2LD8/YPqQr7V99eizTzjK93vzImywosghNSjXujHhGcfdI4Lk5DvHOWxXLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(316002)(41300700001)(31686004)(6916009)(66476007)(8676002)(4326008)(8936002)(66946007)(66556008)(6506007)(5660300002)(6486002)(26005)(36756003)(86362001)(38100700002)(31696002)(6666004)(2906002)(83380400001)(6512007)(478600001)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3JxL3dZNHU5Q2drTUZxZndPN1JmZWsweG03S1M5QWdpdGM3cFB4b092UTRw?=
 =?utf-8?B?cURRVU1sLzlUR05WeUsyTjJrRGNJcHR6NVVXZDEzMURGa3VBS0ZSWXJSbHh4?=
 =?utf-8?B?ZysyYXpsdDRCSVFGc2FaVUdKM3Z3bW93VWZldzZsVkFnWnkrQkh1NkJVWkdV?=
 =?utf-8?B?TXl1c0lqeVoySDZEVDV2Sk0rbEVlQXB4WHU1eUM3VnF5a0dMM0VmNnkzS3JQ?=
 =?utf-8?B?WlZ6RjcxdFh1V1FVamdhclNRMWpTS0dpdmh6QW5sS0JPcHZ0ZXpSdmoyblJt?=
 =?utf-8?B?RzRsTHJFM2MzUnU5TVJkWk1nbXdDc0pQNWtiR3d4REZzTXY0ejRIK0ZpMXVj?=
 =?utf-8?B?aTFpZCtybm9wNDNsK0dpeTJRTG4yS0l1cVNkaHlxMG1DbTdMTWJKZkpUOFRx?=
 =?utf-8?B?SVEzcjRBUDZmRVVuV1hRWEFJcjdsS0M0eXZxczNwdWhPcFlVWWV6OHJ3LzBV?=
 =?utf-8?B?UUhBbmNEMWdLWWFHclJ5ejQyZHpqZmpMZmx5UU8rZ01rbzVuTmxJb1NrSTVp?=
 =?utf-8?B?ZzhQZUVUNmVxZDhKd0pibEs3QkVHeE1KcFR6K0NvYTVOL1NKRTVlZ01RMHJ5?=
 =?utf-8?B?eWtmN1JFdXdLVEJqTldRQll2NDdQL1htOFV3cWVHVC9XUy9EWHNoUEF4YmFT?=
 =?utf-8?B?bEZaR2FSc2dnWE1qZkNFRHpJdHBUZXpKTG11NSt4SDlPejk1aytFYmNvVXpH?=
 =?utf-8?B?aVBCcWp0d2ptMWw0YnhOQkhMUWxLSHRSVWJUNkhqQUN0Q2t1aHVPaitmbUpy?=
 =?utf-8?B?b3RkZ3M3WDN5VWo2ZGJhbXdWOG9VK240NjUwM3FvSXBkY0dsM21VYmpaS0Vk?=
 =?utf-8?B?R0dNMzhna1lWK3BmQkpGakRsdzB0N3YrUzVzdlp2UWxDQzhXUGVaRG5oRXo0?=
 =?utf-8?B?UFdlY1o0Z2VYWXNVeDNmOU9TQVNFZ2p2SkVHL1dGT3R6bWxLc3NLTi96TXRz?=
 =?utf-8?B?eG4zY0ozZGNwL1JEVEMwT1FUVHBmU2hQS2lmNHJWNnBXNG5tTUVKVjNMMlQ4?=
 =?utf-8?B?VTlEc04yZnN3R3lDNXZvekt3akI4cFh3cWVGZ1ovSWZ2OFlRYis5ZzljSW5m?=
 =?utf-8?B?MUNBUVd4KzVQbVgrcHdORlFWazFyUlo1aU03eVBya0lJblM1Mmg4MEEzejRU?=
 =?utf-8?B?eDZySUYrRG5YT3ZzaUNuT2NwakxJd2gremplL1QyeVNzZlRCVHBra3I1dTY3?=
 =?utf-8?B?aEUzSHBuOWZzMTJyZmwyWHBMMEg4RlVONm1hMks4Ukd1UDN0cndiS3R5akRr?=
 =?utf-8?B?Y0wwd25kMDlCenJLcVRtZzJMZ2tDVFdzOU5yYmZaTUlYUjNyUzdoMVFZNkJD?=
 =?utf-8?B?SUlLTWRUdGhwUVZlTVNZamQwdWlCeVkxNEpMb0JTUkdzUnBEWGIrVzdLOUFa?=
 =?utf-8?B?bFUwSzZ0STZuMk1JU3VQYytldGdwMEpZcGkxZC91SXFOZ1pqOWZyKzRyd0Nw?=
 =?utf-8?B?QlIzalZFZktlVEx5QjgyUGRPWjdPWlZmWnBORllpekhlbVIwc2hTaitxWTRn?=
 =?utf-8?B?V3BrQVE1V3k0OGdScXlwZFU4Unl1d3ZaeGpxWWc0bmZweGlORzJaY3pDR1Zj?=
 =?utf-8?B?clJzVW1wZkJJYWRCbDRsRFMvZUFhOVhmc0U0VVVQM1dYNDhDZVBud21qUlhG?=
 =?utf-8?B?L09UREljQlNaWFFCdUhyaGJwK1prS2EwNXZJUEdjZDdsamU5RXlBV283Y09T?=
 =?utf-8?B?Um1QL2F3Ky9MdlBqK2JIVGRLZ1p4c0VOVkw0bFNvZVA3eEJLanZDSVhUbUV4?=
 =?utf-8?B?SFdkNG9qYjhLWktJL0JxWVhyYkRiNnljUW9Fc3VVZnRnd0JaYnYvT1VjY0NV?=
 =?utf-8?B?NGhwUkdYb3dzK3RKNzRucTRYNlJpcWpVV05nUmQ2SjdYSDhhWEJPcndRdTJh?=
 =?utf-8?B?YkFRZVFveHFINjJEMUZXNERlSGdtWjVGUzRyOFQxM1IzWHdsTzc0N3N2d29H?=
 =?utf-8?B?RmlhMnNmTjRRMENObFhRcE1zRERaaU5YQ1Bld1ZXb2x5Mk5LMktEWk4xVVBt?=
 =?utf-8?B?VUt3cmE3ZXg3M1dQVm1OVWV3YzhuQ1A2cUlHeTE5cExLbU9MNDRPNUtYWGp5?=
 =?utf-8?B?dFBXN1V1azc3RnRmYUw2cFRFSnFiNVhkZEV3eU1tYzVPN2s5b2lXbHZHYUxr?=
 =?utf-8?Q?DFFk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56deef81-7dbd-4b5e-9fba-08dbc907f77f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:40:26.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIOlWTbRfnTbaXPHKV5rpcRMQqGpfdgow9Yc+h2aEoNNa+I343V6f2QjqoH+SThi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/10 00:28, David Sterba wrote:
> On Mon, Oct 09, 2023 at 02:04:09PM +1030, Qu Wenruo wrote:
>> The new test case would:
>>
>> - Create a dir as source dir for --rootdir
>> - Add xattr for that source dir
>> - Create a file inside that source dir
>> - Add xattr for that file
>> - Run "mkfs.btrfs --rootdir" with that source dir
>> - Mount the created fs
>> - Make sure the following xattr exists:
>>    * Xattr for the rootdir
>>    * Xattr for that file inside the mount point
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/mkfs-tests/027-rootdir-xattr/test.sh | 40 ++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>   create mode 100755 tests/mkfs-tests/027-rootdir-xattr/test.sh
>>
>> diff --git a/tests/mkfs-tests/027-rootdir-xattr/test.sh b/tests/mkfs-tests/027-rootdir-xattr/test.sh
>> new file mode 100755
>> index 000000000000..bff9dc71d8e0
>> --- /dev/null
>> +++ b/tests/mkfs-tests/027-rootdir-xattr/test.sh
>> @@ -0,0 +1,40 @@
>> +#!/bin/bash
>> +# Test if the source dir has xattr, "mkfs.btrfs --rootdir" would properly copy
>> +# that xattr to the rootdir inode.
>> +
>> +source "$TEST_TOP/common" || exit
>> +
>> +setup_root_helper
>> +prepare_test_dev
>> +
>> +check_global_prereq setfattr
>> +check_global_prereq getfattr
>> +
>> +# Here we don't want to use /tmp, as it's pretty common /tmp is tmpfs, which
>> +# doesn't support xattr.
>> +# Instead we go $TEST_TOP/btrfs-progs-mkfs-tests-027.XXXXXX/ instead.
>> +src_dir=$(mktemp -d --tmpdir=$TEST_TOP btrfs-progs-mkfs-tests-027.XXXXXX)
> 
> In case we want to be sure that the underlying filesystem for temporary
> files supports the feature we want it's better to create a temporary
> btrfs filesystem, either inside the test directory o in /tmp.

Indeed, another btrfs looks much better.

Would update the patch soon.

Thanks,
Qu

> 
> Chosing TEST_TOP is IMO wrong because that's where the test related
> scritps and logs are, this is not meant for temporary files at all.
> 
> Also please use one of the _mktemp helpers.
> 
> I'll apply the first patch with fix, please update the test, thanks.
