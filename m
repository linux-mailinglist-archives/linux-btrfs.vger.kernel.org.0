Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B047D47E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJXHDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 03:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjJXHDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 03:03:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787AA10C;
        Tue, 24 Oct 2023 00:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os/x5GID3NIR461TQjAYibJUyFhHl7yfB6wGFmqeoD9jbRNAPYZWVuOKCGQn/VDDN6/UsrrUP4DcCJaFhrRk15RNcrjC9puqyzGFh+11l8JHkX9hQcV93bIYo5+7JpCr9YvTxHJqRkxz87aYyOUH2OCnfXoen0arqDgy1/5D7HsSIifSm5pr2sjo6B9kiYbYp7UBG0SaZkm+VVxPQWhBEnLo2THzSQgtlrZiYJnZUMtFqRrqK3SH9V57G22WYVbMf/IHZuyaQGNBeWzXhz+muM08aoq3qTcwc1EUEE7b0vCQwZw0gU+o90f3yOpFTYG5EdPHWL0htGGcecynY2sczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgsheh1detU9nY3pas44zYYAy5vd9ifITJSBhucvKwc=;
 b=S/vJbXl0xzWVgrAxAxtSkEXuPmPx7N9HydaUbGSWpRTejV7GZ5PO3zR3LlWc+4CAblwqZeQybWWJAqTPpwvEBErCr7jo7FAeIgAzQWZzAZyfR5iNgwgNuXj81+tesQP9TwyjJs15WwCc3sUMwKUIKzHvmXRJ1iWJbSfVv/ZzZ2gOsHAqUj6nMVHQkLkf+h+D4wn85MLAzygAfRVjdV3Sc2eo/ja/F3sQP4bT/yTct/vV4Tcztw6s3UHFJ//C//v5OIEl8UYQ2rqGVpXKj43mN4tY5QyZG7r4qeA3fUqaBPOjO/hcbQPc0sGvOfIOUSTHZfY7og5qY/OkpTHt7nYJlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgsheh1detU9nY3pas44zYYAy5vd9ifITJSBhucvKwc=;
 b=bb4NSSeqJszXrB+UX/wF8MJyeMrzuxB4vohDk8nyMkJnC15Dx6tiQHStm7GzY90Ir2tXSix/0nJf98kNEuPOZoHMBS28d45xD/Fi0ISJXvBXsNXLsl/DPjfOQIt8FNW12soRSfx3G/nkOhL16SxTmfSqvreowPJ8qKMUPdzuTK7mq7gL3aRQGtvZWBcKlTs9Qg3FqvXnL4n4W/fnfBhRCFgJ8abDH0Yzzg5xtynwTq/4b/DuLxd8/wFaRCU9z9hn76kpSldTCUZcNOP9xD/jhVJl6bpGTR87rWzNBCS22aDA7sFgDhd0DcKDO9V4L3ULpLpG39cs1y770ciZtYP+LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB9953.eurprd04.prod.outlook.com (2603:10a6:800:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 24 Oct
 2023 07:03:10 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5%6]) with mapi id 15.20.6933.008; Tue, 24 Oct 2023
 07:03:10 +0000
Message-ID: <2aac5fa4-3159-40c1-8b49-19a13e4118da@suse.com>
Date:   Tue, 24 Oct 2023 17:33:00 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/353 should accomodate other pwrite
 behaviors
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>, Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org, quwenruo.btrfs@gmx.com,
        esandeen@redhat.com, linux-btrfs@vger.kernel.org
References: <20230901161816.148854-1-bodonnel@redhat.com>
 <20230929050651.7rlyclnxlmzrot3z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZRbUQveXYWjhlvAN@redhat.com> <ZTb2Xy4vTi6/RGQo@redhat.com>
 <20231024052129.5ze2o3wmdolaro5w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20231024052129.5ze2o3wmdolaro5w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0087.ausprd01.prod.outlook.com
 (2603:10c6:220:35::27) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: 739d2bd9-6137-4b1e-4de2-08dbd45f484c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjdFbvVIuuAyGfV0YFE7qYFGTRt2AsWPdP6bt8Mxrxp/eMOfW+WwTkVo8wAUxX7Z7+zMzZ1agChZCKUA/+MF0kRWliptyqCurtjrYQN3nLM58CAGDzDuxkN5m9qh66kYvIM8ds1IR3+SvPvcOphGoPW4uDztAa3lt5d58hG+c9ZAdqsjTkw397Xjz7gMEEvJ829sMbETMvManwvghCWKHbt2OePdbp6ao9t29qMdW3mbEDptXItssz+YtVKIEoVM0FLu8WC/mkDKoaL09kbUmzMzyXrWuaUSTduSV68SjEnpNVIclaXqBEcTRFbShpmPEqhq6E8lECHXPKfudTBPB1zJrXJg9xAgT+3NQ4aElg+tGuEkK0FLtHivFSxqUO3CQRcLT/eigZ/viDjZCQtQ9u9BM/OBhDeAohUH/EEJq/Req25oQcviuWE5A7yl8mcMf8mL2bd+OBVpdHx9u0PSLIeWuAYyN40RgtB3PzGtLFfr5MzIlRzkvbFu/Yvmcb7ESScq6J2h/jFgfMXe5BzRHdr+Sx+1UhCjVn26rIaDsmza/puxNqpXFjMHkutjJhAQ17EWRdJbUVqCu3Qa63r7Gxea+tmayqqXiU8FcM0Mm1hbN0/4tfKc7wYWqna5sAlJF/IjKNqGGj3TKO9bOLvPl8ymsTVc3VP03JEffBuCc5rIX+5dMy9BkmfvUaCKb4/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(41300700001)(5660300002)(86362001)(31696002)(2906002)(6512007)(53546011)(38100700002)(478600001)(6506007)(6666004)(36756003)(6486002)(83380400001)(26005)(2616005)(66556008)(66946007)(31686004)(110136005)(66476007)(316002)(41533002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVpVjdzbnh1QjdBa1BCdEI2MTFzUFhOU1lNOFd0UUVHUlBjM204NWRLRFZE?=
 =?utf-8?B?eG01YVBYb0FCb1ZRdmpneGV5cFFpbzgvTWV5RzlvRzk0RVBXUXF3dFltemp2?=
 =?utf-8?B?eWp3NGwyNitKZUdpUXFHUGF1RWxnYVhSWWhlZ1pmTzM0cGc5N0dvU0luVXk5?=
 =?utf-8?B?NjJudmEwT2kra2c5Q3c5RXc1ZVcxbWVCL20rR09wME5UV0hhL011d25OYTdP?=
 =?utf-8?B?ektjTUN2bkdPM1VZWFpKYVFvQTc0ckZ2OU5XQTFCRGxKYnNtUmhwL3MwTjZ6?=
 =?utf-8?B?WkhvR2RxR3RxSnZLZk5xUUxWcXNhbzVRQ0hlNVdoVjg4Zm12SUpCeDNNdmx3?=
 =?utf-8?B?S1oxYkdzR21iWkNORlF2VTlvSHBrZStFQXBSWEx5WXZtUEhENXdKaVZFamdH?=
 =?utf-8?B?NVZVT3JBZGRQaGtyekYzQUNsSkNpR250VnpnU2VPVURxNHJmL0pWVVE2U0F5?=
 =?utf-8?B?ZktpRnp5c2RLb3UxOEg2bUdGc0cwVi85eHp6U1ovMWgweFVlclVOZjdiVWU3?=
 =?utf-8?B?dlRBUW1yN3lJRmtyR0U0RzFmN1RWOFBxTTlTWEhjTDNYWjgwQjZ4NTdtKzVu?=
 =?utf-8?B?YW55bVBtUVVXaktNK09XeFl1andQSzFVQ2plcm5pUEUzNnllY2xZVm9XYnp4?=
 =?utf-8?B?eWt1UUdtWEI5Vi9MOWdIeHFQbjVNMmErelBQWmxTSG1icU5iRlZZTDVlZCtz?=
 =?utf-8?B?L0RVdGg1M0x3UWJlcUtHU2xkWlhIdU50TDI5OTJqZ29iRGZLV29NRmllMVhm?=
 =?utf-8?B?L3NjY29OTmtBRFRXZ0VKUDdyV1didkt2bUt0TlNqMGswWThHN0luM1ExTUJT?=
 =?utf-8?B?S2twSlpFSzBxcWF6SmdzVTViRjB5aGVWa2pDckRONDlzTkZTS29pMXZnNmJk?=
 =?utf-8?B?UnFTSlR5bUNMTlppL2RmMjU0Unhhd1k0eXEyZncwM2dINzNid2pVQWRMUzFI?=
 =?utf-8?B?RGYvSHY1dnRGREpGamZhVUpyTXkyK2pkczdFQmppbGxFOGNJNmhJWjI3UzBh?=
 =?utf-8?B?QWxLZm1RUUo4UG84VTEwdnhVQWtIZHlNVHdLWFZxVWdxZVFuaHZLamIwQ3J3?=
 =?utf-8?B?dGpnVE1JWDF4eElrRUgvdzRYV05yZDJiam1PejF4V3l3ZjVFSUc5dWluSVJF?=
 =?utf-8?B?ZCtrL0FJZ2dIdlcxS2VRdzRnVU16Q0Z1NDNTbklZS2lnR2g4MTd5cng0dGdG?=
 =?utf-8?B?eTZoU2JadkluSTVnaDM0SzNHNFI5V2NpOVYrbmg4Ym5iZ2ovY0lOMjRRU0Vn?=
 =?utf-8?B?K0NXWnRkQUc2MjJEQjFURVZ2ckdBNDVpbHFvREJGZUVxTFIyazJxQ09yZUtu?=
 =?utf-8?B?SGM4U2k3UHRKYUlsZTZHdHNNVU1kL3ZQNDVodm1zWk9PSjdMQkJXaU9qTnJE?=
 =?utf-8?B?aTFteDdqd0JMMzNBL1lXU0pldTZ5YjN1R3MwbXFNWnJudjRXaG5iS0dvb3dM?=
 =?utf-8?B?L3hJOVFjVVF0RmdEcUxNRGFNK3dVOThzcnZzM1kxV2xrZmlVeklhU0c4Tk5I?=
 =?utf-8?B?QVRxSG96dEt6WU1ENjF3SWJvb2pkdm5WT1pwUk40ZGs0RFh3V1BKOGZocThZ?=
 =?utf-8?B?WENmMGVzaW9tUHBraHU3bStiWmM4ajFQUXAwNzBjMHJPNTllSUxYa2J0YVQ4?=
 =?utf-8?B?MWVPK2t0VnZ6aDdWeGwrNFFPQUVaVXBzODBHSzA1Qkh4d3hZbFVvNWpDZlo0?=
 =?utf-8?B?K3NjV1dTL2dHYk5iZGxHRTFaTXdtaUNzSHNwOTVzNDBucUxCanJ3QnIvbTJ6?=
 =?utf-8?B?d3FScVFsd05LV3loVnVHcmFOd3V6VEgxd29kU1RCS3pKZkFYclNNOUdwUE1C?=
 =?utf-8?B?S05VYVJ4c2VhME9HbUVtSDRRTCs1cm1FV1NDRzVxbEVROVdkM2xiK2RHY3RF?=
 =?utf-8?B?Z1JJdHlseklGZER4K3p5c3lJTytOZjZOSnJNMm5HYUo2YlUzcWptZ0Y2eUFV?=
 =?utf-8?B?UEVmN0sxck9pcXBUUjNJcEVBUDZuMDJRUWFaSnJ1NkVnMHhLSXZiRlBCdXpU?=
 =?utf-8?B?QytzRjgyMTRVWGtOUElEVjNrNm00eVVxdS83NkRIODIxME5iUWpUMFFkdEJN?=
 =?utf-8?B?T1cwemltZDl4angvRml2VG5WSHhBTE8wckozUHNmQ1hPejFZTXNTdjV1WUlY?=
 =?utf-8?Q?U1bQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739d2bd9-6137-4b1e-4de2-08dbd45f484c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 07:03:10.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNeuGG4XZBHMtHbY184t/fy2WYS+Dwfcut5RD8ExOnwkDovP0VfQk0sLyMFt2zM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9953
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/24 15:51, Zorro Lang wrote:
> On Mon, Oct 23, 2023 at 05:40:31PM -0500, Bill O'Donnell wrote:
>> ping?
> 
> Hi Bill,
> 
>>
>> On Fri, Sep 29, 2023 at 08:42:26AM -0500, Bill O'Donnell wrote:
>>> On Fri, Sep 29, 2023 at 01:06:51PM +0800, Zorro Lang wrote:
>>>> On Fri, Sep 01, 2023 at 11:18:16AM -0500, Bill O'Donnell wrote:
>>>>> xfs_io pwrite issues a series of block size writes, but there is no
>>>>> guarantee that the resulting extent(s) will be singular or contiguous.
>>>>> This behavior is acceptable, but the test is flawed in that it expects
>>>>> a single extent for a pwrite.
>>>>>
>>>>> Modify test to use actual blocksize for pwrite and reflink. Also
>>>>> modify it to accommodate pwrite and reflink that produce different
>>>>> mapping results.
>>>>>
>>>>> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
>>>>> ---
>>>>
>>>> This patch makes sense to me, but this case looks like a regression test
>>>> test for a known btrfs issue. But this test case doesn't point out which
>>>> bug/fix does it test for. So I don't know if the 64k blocksize is a
>>>> necessary condition to reproduce the bug.
>>>>
>>>> If we can prove it still can reproduce that bug with this patch at least,
>>>> then it's good to me to merge it.
>>>
>>> I'd like Qu to weigh in on this from the btrfs standpoint.

Weird, this is the first time this mail shows up in my suse.com mailbox, 
but not in my gmx one, maybe it's something wrong with my filter.

Anyway the patch looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

> 
> If there's still not any review points from Qu or other btrfs devels, I'll
> merge this patch in next release.


> Better to make sure if the 64k (multi-blocks)
> is a necessary condition for this case. What's the bug fix this case trying to
> cover?

64K is not a necessary condition, it's just here to allow all btrfs 
sector sizes (4K to 64K) to be covered.

In fact, 64K blocksize on a btrfs with 4K sectorsize can lead to false 
alerts, as there is no guarantee that 64K buffered write would lead to 
one single extent.

The initial bugfix is just a bug inside btrfs' SHARED flag detection 
code, and is completely blocksize unrelated.

So we're safe to change the IO blocksize to ensure the buffered writes 
only lead to a single extent.

Sorry for the late reply (and possibly bad filter setup)

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>>>
>>> Thanks-
>>> Bill
>>>
>>>>
>>>> Thanks,
>>>> Zorro
>>>>
>>>>>   tests/generic/353     | 29 ++++++++++++++++-------------
>>>>>   tests/generic/353.out | 15 +--------------
>>>>>   2 files changed, 17 insertions(+), 27 deletions(-)
>>>>>
>>>>> diff --git a/tests/generic/353 b/tests/generic/353
>>>>> index 9a1471bd..c5639725 100755
>>>>> --- a/tests/generic/353
>>>>> +++ b/tests/generic/353
>>>>> @@ -29,31 +29,34 @@ _require_xfs_io_command "fiemap"
>>>>>   _scratch_mkfs > /dev/null 2>&1
>>>>>   _scratch_mount
>>>>>   
>>>>> -blocksize=64k
>>>>> +blocksize=$(_get_file_block_size $SCRATCH_MNT)
>>>>> +
>>>>>   file1="$SCRATCH_MNT/file1"
>>>>>   file2="$SCRATCH_MNT/file2"
>>>>> +extmap1="$SCRATCH_MNT/extmap1"
>>>>> +extmap2="$SCRATCH_MNT/extmap2"
>>>>>   
>>>>>   # write the initial file
>>>>> -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 | _filter_xfs_io
>>>>> +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 > /dev/null
>>>>>   
>>>>>   # reflink initial file
>>>>> -_reflink_range $file1 0 $file2 0 $blocksize | _filter_xfs_io
>>>>> +_reflink_range $file1 0 $file2 0 $blocksize > /dev/null
>>>>>   
>>>>>   # check their fiemap to make sure it's correct
>>>>> -echo "before sync:"
>>>>> -echo "$file1" | _filter_scratch
>>>>> -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
>>>>> -echo "$file2" | _filter_scratch
>>>>> -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
>>>>> +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
>>>>> +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
>>>>> +
>>>>> +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
>>>>>   
>>>>>   # sync and recheck, to make sure the fiemap doesn't change just
>>>>>   # due to sync
>>>>>   sync
>>>>> -echo "after sync:"
>>>>> -echo "$file1" | _filter_scratch
>>>>> -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
>>>>> -echo "$file2" | _filter_scratch
>>>>> -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
>>>>> +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
>>>>> +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
>>>>> +
>>>>> +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps after sync"
>>>>> +
>>>>> +echo "Silence is golden"
>>>>>   
>>>>>   # success, all done
>>>>>   status=0
>>>>> diff --git a/tests/generic/353.out b/tests/generic/353.out
>>>>> index 4f6e0b92..16ba4f1f 100644
>>>>> --- a/tests/generic/353.out
>>>>> +++ b/tests/generic/353.out
>>>>> @@ -1,15 +1,2 @@
>>>>>   QA output created by 353
>>>>> -wrote 65536/65536 bytes at offset 0
>>>>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> -linked 65536/65536 bytes at offset 0
>>>>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>> -before sync:
>>>>> -SCRATCH_MNT/file1
>>>>> -0: [0..127]: shared|last
>>>>> -SCRATCH_MNT/file2
>>>>> -0: [0..127]: shared|last
>>>>> -after sync:
>>>>> -SCRATCH_MNT/file1
>>>>> -0: [0..127]: shared|last
>>>>> -SCRATCH_MNT/file2
>>>>> -0: [0..127]: shared|last
>>>>> +Silence is golden
>>>>> -- 
>>>>> 2.41.0
>>>>>
>>>>
>>>
>>
> 
