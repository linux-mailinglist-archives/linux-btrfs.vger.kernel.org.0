Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDC439498
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJYLR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 07:17:28 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:39424 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbhJYLR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 07:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635160504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6qdYREEPNpOIrcoCp1Vx2uYHKG4+J7O/yIQr7kaT/qM=;
        b=F5xDOzmZ6ID40bMcFXukUofktoL0LbiY7uARiQVS6LQfMH9097l+pOOGEZMShSupE0mrSX
        Rvy1nyfKKibmKL2mjwW7YzWiagB/C86ywGIW8YTbqSctm7B5frILmqJD4UJVD6DaDMfP3c
        H0VJC+ZPjqBW/R2uZ9i0BpLQX5LvTxA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-vwrPXT2eOQC-D1KvHbOoBQ-1; Mon, 25 Oct 2021 13:15:03 +0200
X-MC-Unique: vwrPXT2eOQC-D1KvHbOoBQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie/bEv51NGZDq2biu7fGHHh36Z0ueq7L2MzxWrw0GNdlpZcxkwlDVBGL2KmfgP0M8iPnP7aIYQjAlH6e5JfD0Sp8arDdsv2y4rG+tXs0JMb3aGwG2uiXP7n2cH6cAsZkWK7sx8QjUBdfMJpkREbiGIVLq+O9ooDT6p/1uJnNbZhAqMLPT5+mSVkD2o780X+UYFVh7QEsArEGraeB/0nk+m0d0NNBdE4oZzxIsF8oJ0dnstzCBHTRJK8VTLaObc7mgOWc8UpME3ZbtCWkJ7Fv/7SkvI3QsEwEOLTuHRI2KgZw4je5hEYPk6XfnPAJ32uqyNg6CTi3fD+FOdxSG5qlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElphcuD6njHeHW7AUkMAwEfQTCjrs7Wgodfoai9NdkE=;
 b=BwdImFMvoOyRMqKj+NiHO46nx3m3NbgDA2AIphAlCDehYfHMIbivMkPZd/6TLTKqdavPkZQIya9s1CdqIcPOlOH1wWo1K1Rr8ftdqrZItjlYF8yhXtOTVANzpTjSDxX4G07BKRCLe154qM032I7VySYRPcso53zzRJSbHFMbylokflFYWjB6pK3Q/oVNX3fN4fjAlrXNmh9nQQO89qCzxIR44VULIQiH3dsrY6FJeQKEXHsEj0jPikp2cn8MbBWrtWu04xMqUuc72GOA8LRMjw2dZnoWH1CwoxPj0xSSMjybQ34D7UOceYmb53y46EPz2mTwzRlDqMQXOpk62XH8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kr33.de; dkim=none (message not signed)
 header.d=none;kr33.de; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3250.eurprd04.prod.outlook.com (2603:10a6:206:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 25 Oct
 2021 11:15:01 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 11:15:01 +0000
Message-ID: <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
Date:   Mon, 25 Oct 2021 19:14:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12 via Frontend Transport; Mon, 25 Oct 2021 11:14:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0802dc7e-4867-4833-e6d1-08d997a8aff6
X-MS-TrafficTypeDiagnostic: AM5PR04MB3250:
X-Microsoft-Antispam-PRVS: <AM5PR04MB32509831437BED5CA4B707F2D6839@AM5PR04MB3250.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVe1FtQJCk1HzpX+y1FfTtcTsWJJ+GquP35jgB9mKgHp6araEwmJojreX6wIwez4xC5zCeXoGGKK2yHPLyZpQGpfJUD9j+iJXOU7YoxdBZdBU8g9nJn/nuCi6x0gt3uhWISdwq5kuEC6/3eDqdLX2rCntyq8R6tYqxEgwRXWqNUr0Wt2Toe3fUUIEYrubCXd4mhm8w1df3E8K6813X+AT8BOOY0xylzMA1UqMKaQ88pH8CwgG+cdL/EKzIuM+XkXaTep/blXW0r4BoFiIHtO61bebYWyMzP8HMzBDpub0N2WTkejRy4w7czEiE7cYSP6WB9nkmQoi4DcbOmmGErOCMKkEms5zmlbhqP1VIJDGlPqR+a/IJA9M+L94sx77y+jcFY4PWgtENqq06Jfy5BPtWv6eBFRfzPWsx9wg3HYAQXBPONkDNUybkCtXNTeyaU5qE5dW2m95Tlva375mMxmIjogImysQSPwBCnpgOQih+XGed2GO1li646Vp1iKZP5iWRYUtLMc41Rlf6MHO9PMZ7aFf05n+XfTA9LWcLZdU9KB7sYBWHnWdsg6cMuW2nrXKjgYUGJ7QHegMwxsUYgBuXsmNnYUAJoihC35so/qk7k5oB03ZLo8IeSzKw1BUR8zv2ih1DnzJe+gsjJK/AAsP2NQJDZoJkea5FM0XghyV6sAVAqoQEF0i7mFUWW7qjj9HfOKANo+XBwXpcrLpoP/i8XsAUMmG8hdWSxYodu8CEHW/p9WOllOtq9g54rP2Rav9FoyxE1RNr0XiMisjkYDylfeZMilZpKQRBbWBwTHTelB++3c6kbuEB+VSuQM/MMo5Hz4xQKTWL09T04I/r1xOKlbKYJOJ6f2f0K486Wzf80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(966005)(53546011)(508600001)(31686004)(5660300002)(38100700002)(110136005)(16576012)(36756003)(956004)(2616005)(6486002)(26005)(8676002)(66556008)(66476007)(8936002)(86362001)(66946007)(186003)(6666004)(6706004)(31696002)(83380400001)(2906002)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRfV0by2lNWU/wrYse5Aeuq8YlurcevYLo7T2ZjtN5W5meVbQY2XPACJd8qN?=
 =?us-ascii?Q?ZOtnc5wtY7W4TNYQ/rz9jU5d6qKqJbFkLEVhePNNBY9IFl4491GJjgdEOUz4?=
 =?us-ascii?Q?bIpXlCQQcXMiPBB+4RXQjGgEFdZmhk01mzGGmYJNLi8mtVlerDj2+QsazZGI?=
 =?us-ascii?Q?FWBWi65fcE5mUPGf/WBHeq/tj5MeL82PvHrkrTBDH8ohWXZoEwxKmGHkqMOs?=
 =?us-ascii?Q?nULbH1htaa3IZW7n+spPSgM0GBO/xwdMGaZ660kj85ZstMEpKCVHjIkQfBaT?=
 =?us-ascii?Q?nnYXUnM4GvNjryhS3YJ/WCUFxjGogxa3TJ4hjRo7pDxXzvLMbMLXrFrNjpT5?=
 =?us-ascii?Q?1WJfXSH04m54ljJXH2SWVZ7spDeDpJAMas52k9wQAcvaFQqaoRU3dWTk6MPG?=
 =?us-ascii?Q?aJzvNuFyJIRAhyu6OTf8PjeruGYUD2NsHXJgTs8GiV/eDzCGmQbQpLROUFg7?=
 =?us-ascii?Q?w5bTShq3oqVlWCstTIBqOk2tS043jsLu+8EikKEMlQyP5Vx6jTZb6rIsV2MU?=
 =?us-ascii?Q?QI5R/LEdvDs7Y6mq2BGb1fY9RFQfKF+xjEbZ8yjJ8QKjSvkKqteaI5C7IwBK?=
 =?us-ascii?Q?Te71bJL7T7vinlTJ4BqJajQ+cxMXpj2iI1vuAsLVu0It9mNEYJixqlsUeAxN?=
 =?us-ascii?Q?rJgitZUjNFkQL8+KZAAWmr5AWDoN/RHaD0GdvK10WvI9lQKLsPQTzs1BMnP9?=
 =?us-ascii?Q?DjP9P7/bFLOqihTJyjR0ti1y1CTWSpIlv0jLM6D45Seave6kaTVwvi1XbhUX?=
 =?us-ascii?Q?2nVPGKFIKfRJh7EkMCSdtH2/KjepGJWmpXHXLXFvwcfPFvv62BOgKqQmppFd?=
 =?us-ascii?Q?Dh1S8bD97iXj7L46Oj2XUoWCEwfqKA5ltGbTMlOcY/aVKY2gdjq1+wZ9hj9H?=
 =?us-ascii?Q?PmKojd74/dpJY4oxStCZabTlagh43lfPa+9tJ1sXCOOxuWWBQWTRSYTumQ9b?=
 =?us-ascii?Q?T7kMNPNExPtAMo3Kf1BhvadJsC5OK5HqWIT2o4MkOG2U3zxF/OPoO76PaMiF?=
 =?us-ascii?Q?l3y57T8NBts0xUGXjvat9qR3yRiWguEbIrekw1yhF9bYtdF8oWixz0mbujMt?=
 =?us-ascii?Q?yNvtYGPxW72HsNrUCQr/IMRUlbLmngq7vTqqCcMPIsLGnGaaQoUUcd1AIpzo?=
 =?us-ascii?Q?Kbrcpbv7ODbvvVfCRU640dxxcsI3SY+fSwYatN+UvU6oXPNbKKQz6/EUvbM1?=
 =?us-ascii?Q?PdQgwmFR1jRaoXNd9sO6Cm/i1Taw6jJXexuWyGF7Fc678dibymubNeujokn+?=
 =?us-ascii?Q?8Ak6Zr8Kckh1rDYO/+EQy4jbW47yTZpUVWbXBkAe3K3k6NuO1rIZopqLhCVN?=
 =?us-ascii?Q?t85IHHzpvVvZfvRMR7On3OcC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802dc7e-4867-4833-e6d1-08d997a8aff6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:15:01.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjxoaHowfDgTOQkLBNxlcKfSyBz8PqYpWE9jj/KQoOCjkhszRT50eeIijneXesDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3250
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/25 19:13, Mia wrote:
> Hi Qu,
>=20
> thanks for your response.
> Here the output of btrfs check:=20
> https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2

Unfortunately it's not full, and it's using an old btrfs-progs which can=20
cause false alert.

Please use latest btrfs-progs v5.14.2 to re-check.

Thanks,
Qu
>=20
> Thanks,
> Mia
>=20
> ------ Originalnachricht ------
> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
> Gesendet: 25.10.2021 12:55:46
> Betreff: Re: filesystem corrupt - error -117
>=20
>>
>>
>> On 2021/10/25 18:53, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/10/25 16:46, Mia wrote:
>>>> Hello,
>>>> I need support since my root filesystem just went readonly :(
>>>>
>>>> [641955.981560] BTRFS error (device sda3): tree block 342685007872=20
>>>> owner
>>>> 7 already locked by pid=3D8099, extent tree corruption detected
>>>
>>> This line explains itself.
>>>
>>> Your extent tree is no corrupted, thus it allocated a new tree block
>>
>> I missed the "w" for the word "now"...
>>
>>> which is in fact already hold by other tree.
>>>
>>> This means your metadata is no longer protected properly by COW.
>>>
>>> "btrfs check" is highly recommended to expose the root cause.
>>>
>>>>
>>>> root@rx1 ~ # btrfs fi show
>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12GiB
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB used=
 199.08GiB path /dev/sda3
>>>>
>>>> root@rx1 ~ # btrfs fi df /
>>>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>>>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>>>
>>>> root@rx1 ~ # btrfs --version
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :(
>>>> btrfs-progs v4.20.1
>>>>
>>>>
>>>> root@rx1 ~ # uname -a
>>>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) x86_64
>>>> GNU/Linux
>>>
>>> This is a little old for btrfs, but I don't think that's the cause.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Hope someone can help.
>>>> Regrads
>>>> Mia
>>>>
>=20

