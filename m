Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D66315C24
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 02:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhBJBXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 20:23:55 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:55265 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235019AbhBJBVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 20:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612920028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2hQhxTRV4haXbEmX9/qRev3VRPBJ/K1AL5pacg+Q4k=;
        b=CzcdMQ97rHOxSpfdemBysQ5o+52dFxU8v7/+GRPE026ESSGYhzheDg9kYi7zIoD4TRFFO9
        VUOte6p73YGAwl2Zv+NusL9T2eOj5nbaDsLBJr3AgAheTErWQw/4oTdVhgo/hqlxzQtOfN
        ONU0elku41MurRBuq7/FzntQZfej5Zc=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-DJqqB127P_SJqN2TXXc0Ug-2; Wed, 10 Feb 2021 02:20:27 +0100
X-MC-Unique: DJqqB127P_SJqN2TXXc0Ug-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWEW8lTWnmfbl9jZIDeOBv0S1PCpYRppdJ7ZbXBkSKhuxl7g3iyoOTtaXNrEyLPASPEO5bjeSKrYwfT2uwRamvy/TR7uG2MrI+p4RKKz1eaT4jqBjb+Lb9jc72b6lpNIucqx9TCdqkZDYjKrtXlXlLNXMdIb3jz+SI3TUZpJr9H7JF6koZWA5TV3yUH6GRX+jV/AAIUdsm2evrZtoX2wisnGdEjDQ7exatMJvDU7gMoxhkOr2P2F5PXpNR7vKIlMM3ah1rYAxTxTVbnDXXA4QNHIsb7gN3fdDHeWYMeJ+noTPJLkzjpvtCVWjk2kk0lScoRZi6nJhZ5WKUB9k5hjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJxcEA8jdK/MNVkIai9ksR3nA2r1Mb+lEQNLWdCpx3w=;
 b=f6BZUA9cgTrhP807tO63Ch5rjKhAcHJF76flXrCGhu5Oya5fqcbLz2sgv1mzE+ffo9X1HH+hJKeU/sSiC1CXctYZOPAZ2pkRMwv3/h8Xn7dpT0uRSxlvrYh4xZteO9/EoopI9vSxKaxYqBIH+yMeTLxZYVtM6wrQG0rBS2nlqbAwkVNv4lcadnEfwoysm3mGpOnD6in0iDaijLAciO6SrLISjmQCZAlbUWRM+kkVnwyVB/NXFSLxU1oyUcfEv5+JXRNJ7Fm+vPi7Qpao9OdRbRU0pFh0S393Aef9HA9l06MErhaCCQwR/yI9zYtRTPgVwkTE3H8pPfaAHKFmWub6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: konsulko.com; dkim=none (message not signed)
 header.d=none;konsulko.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VE1PR04MB7453.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Wed, 10 Feb
 2021 01:20:24 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 01:20:23 +0000
To:     Marek Behun <marek.behun@nic.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Tom Rini <trini@konsulko.com>
References: <20210209173337.16621-1-marek.behun@nic.cz>
 <40e38323-0013-6799-1527-02cbac8dc93e@gmx.com>
 <20210210020549.6881d90a@nic.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH u-boot] fs: btrfs: do not fail when offset of a ROOT_ITEM
 is not -1
Message-ID: <0acf2948-3a13-a2b8-d480-7fc2af1bfb8a@suse.com>
Date:   Wed, 10 Feb 2021 09:20:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210210020549.6881d90a@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 01:20:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce1935f-f908-4e9e-bcca-08d8cd620a44
X-MS-TrafficTypeDiagnostic: VE1PR04MB7453:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB74530B20ADA4893A2D211F43D68D9@VE1PR04MB7453.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvlWlGGZoifZqRyXTHqFir46woEvjVHzrszL53oPZR/Ljf2sPi6s9pu+jkmOYJ7zWGF2SlaAfgpcz1clzFWCOJLNYyoEBaDo1LnXO2XrHTi38Bmb0qDl6oYZdCL2aVMJxSw4W+rvgfKfMruORCRT3txBZ3YIGYJweWpU2O6/hkrMtyMGLPEZSv1LjjjsPCgCW3hvQk6y3verWixDlNKh8jR9/0u2P42oLomQAhAUpS0L5ou6whieTo9PV5BH6mv7A27qkCsj2FZQ5EeQY3TBqR7yHfKMfn5YEaHEBJ5jery/ll9LYt/uYLAU1uteyGcWdsm6KTFyJGHs5p9W/55P2Meis0bDS717xVFwwI1eVEHE0918ss/qV2IqOiuI0W1qPawthw57LLEwHCEX94bjY9FwnWvYEeXOsS1uQygImFR1ulhjfpQUuQFJLEuHUPEUBainCMhvIEQMaYA64JqWvJ/aFt7Pwu/+FqLJwffOpP+ApYSE/Cu2aRBXDLTODGYtOav3ouFD7nQmSortBr2gAKdnvJZmwmJd3TGT/U+AbA8Nd7v3p1aOSDEVuiwqvQeqpArpC83bZPNWsjpnlm8eNC83pAyh7pMqCye/mLAkf9CpbzKTkmF165BYRecgtPUg5JcGxPk6eiG3P6B68G+YZuntvG9Vz0PGciDlqH1EEyFp3EL1TFTxtRlYrM5hBM79UhpuydYaD/J3UBMJWaDvFxvLdpvNx1JnZEOGuiYXOYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(478600001)(4326008)(31696002)(31686004)(8936002)(66946007)(54906003)(966005)(36756003)(2906002)(86362001)(6666004)(66574015)(52116002)(26005)(66556008)(110136005)(66476007)(16526019)(186003)(2616005)(6706004)(316002)(16576012)(8676002)(6486002)(5660300002)(956004)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g888nGVFlyO0G28I1r3mwLAs/ZAA9fffyoqKSUACqqWXkhBplBh/ev1GQLt1?=
 =?us-ascii?Q?xz867nCKvFxYCs76EYZB2C7Jc7XX1ORGEvkovGVkHRzqiwUbl0JTOx97+nvS?=
 =?us-ascii?Q?fQ9C5C9ghjZFcNKhlEdn6d2bffKXSqasY+mieNkV8p00uoohsLZOg8RNQNNt?=
 =?us-ascii?Q?+y4c1zz6qvzfV9KEOxeHkl6vOmSMh2avtf1JMD6GJB3XtTr9nzIJVDBFMMhA?=
 =?us-ascii?Q?xI+A/ftj7a2LJwpLGN3g52Zq6uRhZDi7QXkbQjuEv9biOyX6UFZBVVqEb7GS?=
 =?us-ascii?Q?i8lG4iaBQ+36XHvCX2lM5IGXPxaf4O/cw1wpfHFz9lLh3CVll13Jx4qGcE4I?=
 =?us-ascii?Q?O8IQc1JatXxdwQsEn9yRaKkj/opEbuBTxlzIsqi1I55X9CFxaUeXFUOjwYUv?=
 =?us-ascii?Q?etR+jf/PfgM0AR2fxJG/RGpfnrZwrD8juZPzc7zNQfFC8lPFjT7wTIgGVs/i?=
 =?us-ascii?Q?lbD/1RnZwF1Z6Lk9Rz2D0fkygLL9L5swJ6cQ5O0BS5GIF0V072YE97L402f7?=
 =?us-ascii?Q?vp+GCRHHc/eduvR4OV/VwoL95/Sy1Lg8XcRv7UekBONfc/nws4n31QewUzo4?=
 =?us-ascii?Q?4dk85UXV7svhVvrkw966cD7/QtCptn2sM0C6EjrlGqnS9yWcQmhBxhItmDgZ?=
 =?us-ascii?Q?uCUKhKMBDXgTZTKWep1APtSewBZkJh9L9lM9rSXYNQD7hx46s76pl0BSKO6X?=
 =?us-ascii?Q?Sr77Qn8kAnbmffsVkgAs2z+xzF5OSfeY5JEGViW6S+KuTVC28i5d87jv0GWi?=
 =?us-ascii?Q?kHP5UqRfEPSmeulDzPcoK+qlfBtjt/0LejBW/q+VpoUQe/kirmEY3WgWy7U/?=
 =?us-ascii?Q?l3E7g+m+vlgwD1ZKdQNeov5kYOv5eueZAuuYJCHOCkyC2N7E/DESe2Np0MG9?=
 =?us-ascii?Q?XGn9GuXdk/FhQuFcSG1y1zhbGqz8UyWBKLYFMyII048RdqvZYyaBOkr5KHG3?=
 =?us-ascii?Q?bzfcaZ0EWX8JxL+lAuW5Wlp4wSDJBQajXjDt53HPjIa5T6KUHoRB9fww60vx?=
 =?us-ascii?Q?4QZ96XDZnt4VZ7bu0QrXrPjVFezn94qpuVJqZCTKa9DFPoT/sy/63J8Jg//E?=
 =?us-ascii?Q?ntYeq0C7TqXMdKz7XSHHeMnPcPcQlhQW4ypYrdJzRGpmjCOhGFdayEjTQXsT?=
 =?us-ascii?Q?/y/50g1GW7SjLk8AfcuNJed0IcIq5DxoeF5TBs2a9Vv0aeWTa492KDES49ZK?=
 =?us-ascii?Q?4CGl56Mu1YuWoHZqoj9IWQvUM/7c6yObdZHom7Gjm8aJ3tGBYhPxspdAwkKu?=
 =?us-ascii?Q?lQrPsydUpdL+6omG0emLlqAIsYeEeqXLWAlwbAWXmTkJUR1aVSfYMkOf6IJ/?=
 =?us-ascii?Q?PFPoVsDKZj5rlw9/RMdjrnHE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce1935f-f908-4e9e-bcca-08d8cd620a44
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 01:20:23.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9+8Xcv2jZM4Eq3KA1D0dkD6D7ekom+oVPAFgsKA5UvMcH4mRUZYCyQhENIV4sff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/10 =E4=B8=8A=E5=8D=889:05, Marek Behun wrote:
> On Wed, 10 Feb 2021 08:09:14 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>> On 2021/2/10 =E4=B8=8A=E5=8D=881:33, Marek Beh=C3=BAn wrote:
>>> When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
>>> location key offset other than -1, it currently fails via BUG_ON.
>>>
>>> The offset can have other value than -1, though. This can happen for
>>> example if a subvolume is renamed:
>>>
>>>     $ btrfs subvolume create X && sync
>>>     Create subvolume './X'
>>>     $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
>>>           location key (270 ROOT_ITEM 18446744073709551615) type DIR
>>>           transid 283 data_len 0 name_len 1
>>>           name: X
>>>     $ mv X Y && sync
>>>     $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
>>>           location key (270 ROOT_ITEM 0) type DIR
>>>           transid 285 data_len 0 name_len 1
>>>           name: Y
>>>
>>> As can be seen the offset changed from -1ULL to 0.
>>
>>
>> Offset for subvolume ROOT_ITEM can be other values, especially for
>> snapshot that offset is the transid when it get created.
>>
>> But the problem is, if we call btrfs_read_fs_root() for subvolume tree,
>> the offset of the key really doesn't matter, the only important thing is
>> the objectid.
>>
>> Thus we use that BUG_ON() to catch careless callers.
>>
>> Would you please provide a case where we wrongly call
>> btrfs_read_fs_root() with incorrect offset inside btrfs-progs/uboot?
>>
>> I believe that would be the proper way to fix.
>=20
> Qu,
>=20
> this can be triggered in U-Boot when listing a directory containing a
> subvolume that was renamed:
>    - create a subvolume && sync
>    - rename subvolume && sync
>    - umount, reboot, list the directory containing the subvolume in
>      u-boot
> It will also break when you want to read a file that has a subvolume in
> it's path (e.g. `read mmc 0 0x10000000 /renamed-subvol/file`).
>=20
> I found out this btrfs-progs commit:
>    https://github.com/kdave/btrfs-progs/commit/10f1af0fe7de5a0310657993c7=
c21a1d78087e56
> This commit ensures that while searching a directory recursively, when
> a ROOT_ITEM is encountered, the offset of its location is changed to -1
> before passing the location to btrfs_read_fs_root().

That's what I expect the code to do, but you're right, if kernel is not=20
doing it anymore, I prefer the kernel behavior.

>=20
> So maybe we could do this in u-boot as well, but why do this? Linux'
> btrfs driver does not check whether the offset is -1. So why do it here?

You're correct, the kernel is using new schema, btrfs_get_fs_root(),=20
which only requires root objectid and completely get rid of the=20
offset/type, which is far less possible to call with wrong parameters.

It would be a good timing to sync the code between kernel and=20
progs/u-boot now.

>=20
> BTW, Qu, I think we have to change the BUG_ON code in U-Boot's btrfs
> driver. BUG_ON in U-Boot calls a complete SOC reset. We can't break
> whole U-Boot simply because btrfs partition contains broken data.
> U-Boot commands must fail in such a case, not reset the SOC.

Well, progs (and even kernel) is a mine-field for BUG_ON()s.

But at least for kernel, it's protected by tree-checker which rejects=20
invalid on-disk data before it reaches btrfs code, thus mostly kernel=20
BUG_ON()s are really hard to hit (a lot of them are even impossible to=20
hit after the introduction of tree-checker), and indicate real problems.

For now, the BUG_ON()s in U-boot still indicates problems that we can't=20
really solve or doesn't expect at all in btrfs realm, e.g. the BUG_ON()=20
you're hitting (call sites problem).

I admit it's a pain in the ass for full SoC reset, but I don't have any=20
better alternatives yet.

The mid to long term solution would be introducing tree-checker to=20
U-boot, so that the remaining BUG_ON()s are really code bugs.

Thanks,
Qu

>=20
> Marek
>=20

