Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D202BA4F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKTIn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 03:43:28 -0500
Received: from de-smtp-delivery-52.mimecast.com ([62.140.7.52]:43378 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727061AbgKTIn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 03:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605861803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=498p+ChljjuNT9CWgaZ1Cp7Znhw3riJ7KDGPoysS/l0=;
        b=LdreSFNG2k2idX8qep/vUCnuY7Ripjxkv8f5tRsR+87ojDq7HhdSRxsJrLEV3d9QFXdnvt
        v1ENk/wYbelpQ4Afy/+hmwkTAnWWY/h2A+LNjBTJI3RAkXRYgyT8RIR935Yrm4/sPlUiLL
        ACuOjNa9p7WFqVAygoRUjMR+lamBLDo=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-4AhqjQZgOqKvFnoU0hpI4A-1; Fri, 20 Nov 2020 09:43:21 +0100
X-MC-Unique: 4AhqjQZgOqKvFnoU0hpI4A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezaa0uAIOK9ha0D2WR9R1q//7f1J8eZaftxfMStPRVMFhoQHYAt7ZxaGRCPb9Om9z8sOhRwm/hxG3rzeLG3VNNg0NHTgxQh+mnbbcvEtQHUIdct+tVEXkSP23a6BMXsUmnHm2Yp2tBsXCpgY2+onTajOLMLWA+/sAJCMWnTA1WMBcv9Txz1Me0aIE3yBWCXRbniTvg9eMx8GGryxfFghUO1dwvWhwHgQA8VIwXP4I2S3gqHQVTOxn+4ZM4MNddXBhHrIIpDVKZMBK1HmSn//4YawnEvrS9mw1HVtcueqxDbRVUtfaBtJdDqtcJ8NSGV33jRMRAIGDd3gR1ySQv3LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=498p+ChljjuNT9CWgaZ1Cp7Znhw3riJ7KDGPoysS/l0=;
 b=dwmFDFRr5pFRgyJCZ8gUoLWtLzBj19zFVqyk1P1ZsS76UwJ+0sg3uVF21qApEGXKVkvxhBu5pmxzUX9lrsc3x6Vp1PO86zBVFd8JkbQb8VAMUt1Bu3l8L405fQhdR+r4nk+cqEie0iH8oMhD8fN46bM5ssuZwvAfBk1wp6KGBV+q4FGsd8nlULWuOtkLRvaUt/UESAtuvbQ4AYz15iM8qpQIuPO4UlChWPut2Fbfd7tgYGR1uUlsP4Ib+Uvgoh9NHXBX53wq4eRRsQAWIvinv7SzvkL3N8g5yQQdVlwoTqDU6TpbbMbpVSfKmiVBED4v/2sG0FiCXl3DE4i1EW7GBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7211.eurprd04.prod.outlook.com (2603:10a6:102:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 08:43:20 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 08:43:20 +0000
Subject: Re: [PATCH v2 2/3] btrfs-progs: inspect: Fix logical-resolve file
 path lookup
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com
References: <20201116173249.11847-1-marcos@mpdesouza.com>
 <20201116173249.11847-3-marcos@mpdesouza.com>
 <977d37a3-5240-c5d6-b117-d91f0e5a5f9c@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <4b38494a-2245-f717-e794-5b3d9c441db7@suse.com>
Date:   Fri, 20 Nov 2020 16:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <977d37a3-5240-c5d6-b117-d91f0e5a5f9c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c6oGQibLfPNlptT4Lma0r144YJugWJOW7"
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend Transport; Fri, 20 Nov 2020 08:43:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff81640-67eb-48f6-01ad-08d88d305515
X-MS-TrafficTypeDiagnostic: PR3PR04MB7211:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB7211B543734D5FCD7FAAB564D6FF0@PR3PR04MB7211.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQpHpuaJMEOZXzz6hslvyZMusLCld5EY4IxGqfMipDUbfGSzWcKh8t5Q4eq8ymHuPTrrHf1xKBG8JusJP+OCIKE6Ib02T6pW2HbD+2CDbB9Hm7jWue6pw+H3u4NqsHFQ7yAreEALI6ouiYJ4uhaA7/YIKRK3x3jnmTneLPgmHHleHV0b8aOYMNe6Tgc3vAggcL0SsjAXXmZUWvY8zgAbjyJIVSRJkI2aySQgImwruPNARhaDyYWtIvb/1oW5RUzRpajhHQQrDaCUJtNM47iix1Ce2HD/ckrFXk53UjyKL4LMZdlY573fQqqaKnAVXDb+Y81gxyEGWiz3GZEsi9xNOA8gCUaLYywlIH5LoYIHEd/b/P7b8jlU2i8r0oxZqh7DQYdvW6kZB3PoiTAnBziyQC0IZvCO7RRbYQPWCxXkFjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(376002)(136003)(478600001)(6666004)(33964004)(52116002)(83380400001)(86362001)(2906002)(107886003)(36756003)(31686004)(5660300002)(6486002)(6706004)(66946007)(4326008)(66556008)(66476007)(16526019)(186003)(8936002)(235185007)(8676002)(26005)(31696002)(110136005)(16576012)(316002)(956004)(2616005)(21480400003)(21314003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ob6kWZAjZl0tvZcmcS2X42N8pStTZK2ZhtUvCk508X70OVAro2WqxFu//MyykwFFD1WNgJhhhbQnnYH2AUW/Yx4F3E9hkBvazQTpnGMNW+3X7W1DL8PtnwPjxuMNquNpmvkAQvlf8OOTM4siYieWS/knqk+Q3g/mAn+8P1OQ5O4DynzL5y9pxUPoQGCvAUIRFUQkl23NevUZlXpdknViuvo/HmHSsnP70fp9/1KQ3Uw2Epj8eMn9+R9EohgAhBi7qldosaGIjQau79q3MUg9RilKPmGtkOWueKi3Kqt0zRZOe5LmiF3Jvd9tPD6zDNpuYsqQi1NVbMe5/qJnGtmJNT/2APBpsy6zDa8CJIOadFBTtDgwop2dtq9dvLL/fN3BvE8YruDGpSNCT4QN6u61z1Qi24fMKXizq+VXBd6hZpW64ReKhnoVFtGF89n7CbrZOjbDTEpEFi+g3zn2vvW8CqqbBbp4REJ01b3mh5+Y0G/gDbHCGGGAO0xGH9nzLvYZcPCR6/zSdPBBqUVPWg2+VTzWUkO6djpiLjKShMQby7XYet0fmyaD6uYIoIP6IwbJCt0QZ+37zeGsp9zKomFx7vv/bp1GDWAsQjVK46CeEf+9nmaSlN+KhGFTl+siwdHUlSQnwWnR59yRgP+Uhfge4xMOSWca+gzUaqfDXMbP+5CYvdkkRL4y1lLP6UXGq1Abf6LXMFqzm9aZkZjqgIJhWr9o2vSHn3xgFwS5Mk1SuD9p/9NG6K12R3J2NT2dHNLrfq37caHf8tyCXsh1eUVg7lWUpzfoq2bjZ6O7uITIo4nojN4CgxFGEx8EsSk02kRMBXURI08Ic985ql/fSp7lrXuflvlUjmV7c84fPr2FpZ4ObkNBSFkVzdxySFmwHLTfCdXFvFPPgKaUiL23eoLsyA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff81640-67eb-48f6-01ad-08d88d305515
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 08:43:19.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn9Zj9EjqIVfyHF6F//lEm9vh2QF8U1leBbI8z0YfHRJS1Q2Ko/EUfdHSwFxTQ1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7211
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--c6oGQibLfPNlptT4Lma0r144YJugWJOW7
Content-Type: multipart/mixed; boundary="aCLcYCY5nVeVZYqYiaPjJI4WSM6ZGAK8V"

--aCLcYCY5nVeVZYqYiaPjJI4WSM6ZGAK8V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/20 =E4=B8=8B=E5=8D=884:32, Qu Wenruo wrote:
>=20
>=20
> On 2020/11/17 =E4=B8=8A=E5=8D=881:32, Marcos Paulo de Souza wrote:
>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>
>> [BUG]
>> logical-resolve is currently broken on systems that have a child
>> subvolume being mounted without access to the parent subvolume.
>> This is the default for SLE/openSUSE installations. openSUSE has the
>> subvolume '@' as the parent of all other subvolumes like /boot, /home.=

>> The subvolume '@' is never mounted, and accessed, but only it's child:=

>>
>> mount | grep btrfs
>> /dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache,subvolid=3D267,=
subvol=3D/@/.snapshots/1/snapshot)
>> /dev/sda2 on /opt type btrfs (rw,relatime,ssd,space_cache,subvolid=3D2=
62,subvol=3D/@/opt)
>> /dev/sda2 on /boot/grub2/i386-pc type btrfs (rw,relatime,ssd,space_cac=
he,subvolid=3D265,subvol=3D/@/boot/grub2/i386-pc)
>>
>> logical-resolve command calls btrfs_list_path_for_root, that returns t=
he
>> subvolume full-path that corresponds to the tree id of the logical
>> address. As the name implies, the 'full-path' returns all subvolumes,
>> starting from '@'. Later on, btrfs_open_dir is calles using the path
>> returned, but it fails to resolve it since it contains the '@' and thi=
s
>> subvolume cannot be accessed.
>>
>> The same problem can be triggered to any user that calls for
>> logical-resolve on a child subvolume that has the parent subvolume
>> not accessible.
>>
>> Another problem in the current approach is that it believes that a
>> subvolume will be mounted in a directory with the same name e.g /@/boo=
t
>> being mounted in /boot. When this is not true, the code also fails,
>> since it uses the subvolume name as the path accessible by the user.
>>
>> [FIX]
>> Extent the find_mount_root function by allowing it to check for mnt_op=
ts
>> member of mntent struct. Using this new approach we can change
>> logical-resolve command to search for subvolid=3DXXX,subvol=3DYYY. Thi=
s is
>> the two problems stated above by not trusting the subvolume name being=

>> the mountpoint name, and not following the subvolume tree blindly.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>  cmds/inspect.c | 30 ++++++++++++++++++++++--------
>>  common/utils.c | 13 +++++++++----
>>  common/utils.h |  5 ++++-
>>  3 files changed, 35 insertions(+), 13 deletions(-)
>>
>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>> index 2530b904..0dc62d18 100644
>> --- a/cmds/inspect.c
>> +++ b/cmds/inspect.c
>> @@ -245,15 +245,29 @@ static int cmd_inspect_logical_resolve(const str=
uct cmd_struct *cmd,
>>  				path_ptr[-1] =3D '\0';
>>  				path_fd =3D fd;
>>  			} else {
>> -				path_ptr[-1] =3D '/';
>> -				ret =3D snprintf(path_ptr, bytes_left, "%s",
>> -						name);
>> -				free(name);
>> -				if (ret >=3D bytes_left) {
>> -					error("path buffer too small: %d bytes",
>> -							bytes_left - ret);
>> +				char *mounted =3D NULL;
>> +				char volid_str[PATH_MAX];
>> +
>> +				/*
>> +				 * btrfs_list_path_for_root returns the full
>> +				 * path to the subvolume pointed by root, but the
>> +				 * subvolume can be mounted in a directory name
>> +				 * different from the subvolume name. In this
>> +				 * case we need to find the correct mountpoint
>> +				 * using same subvol path and subvol id found
>> +				 * before.
>> +				 */
>> +				snprintf(volid_str, PATH_MAX, "subvolid=3D%llu,subvol=3D/%s",
>> +						root, name);
>> +
>> +				ret =3D find_mount_root(full_path, volid_str,
>> +						BTRFS_FIND_ROOT_OPTS, &mounted);
>> +				if (ret < 0)
>>  					goto out;
>> -				}
>=20
> OK, I see how you utilize the new parameter now.
>=20
> But considering there is only one user for BTRFS_FIND_ROOT_OPTS, i
> really hope to not touching the existing callers.
> Anyway this is just a nitpick, and mostly personal taste.
>=20
> Another thing is, what if we bind mount a dir of btrfs to another locat=
ion.
> Wouldn't this trick the find_mount_root() again?
>=20
> Personally speaking, we should only permit subvolume entry to be passes=

> to the btrfs-logical-resolve command to avoid such problems.

Another thing is, if we can't access some subvolume, we just exist right
now, without checking next possible entry.

Furthermore, exiting without mentioning that the resolved path is not
the only path can give user some false illusion, e.g. deleting that file
is ensured to release that logical.

So at least we should do some prompt to inform the user there is some
other files referring to the logical bytenr, but we can't access right
now. (Maybe also output the subvolume path and inode)

Thanks,
Qu
>=20
> Thanks,
> Qu
>> +
>> +				strncpy(full_path, mounted, PATH_MAX);
>> +				free(mounted);
>> +
>>  				path_fd =3D btrfs_open_dir(full_path, &dirs, 1);
>>  				if (path_fd < 0) {
>>  					ret =3D -ENOENT;
>> diff --git a/common/utils.c b/common/utils.c
>> index 1c264455..7e6f406b 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -1261,8 +1261,6 @@ int find_mount_root(const char *path, const char=
 *data, u8 flag, char **mount_ro
>>  	char *cmp_field =3D NULL;
>>  	bool found;
>> =20
>> -	BUG_ON(flag !=3D BTRFS_FIND_ROOT_PATH);
>> -
>>  	fd =3D open(path, O_RDONLY | O_NOATIME);
>>  	if (fd < 0)
>>  		return -errno;
>> @@ -1273,11 +1271,18 @@ int find_mount_root(const char *path, const ch=
ar *data, u8 flag, char **mount_ro
>>  		return -errno;
>> =20
>>  	while ((ent =3D getmntent(mnttab))) {
>> -		cmp_field =3D ent->mnt_dir;
>> +		/* BTRFS_FIND_ROOT_PATH is the default behavior */
>> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
>> +			cmp_field =3D ent->mnt_opts;
>> +		else
>> +			cmp_field =3D ent->mnt_dir;
>> =20
>>  		len =3D strlen(cmp_field);
>> =20
>> -		found =3D strncmp(cmp_field, data, len) =3D=3D 0;
>> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
>> +			found =3D strstr(cmp_field, data) !=3D NULL;
>> +		else
>> +			found =3D strncmp(cmp_field, data, len) =3D=3D 0;
>> =20
>>  		if (found) {
>>  			/* match found and use the latest match */
>> diff --git a/common/utils.h b/common/utils.h
>> index 449e1d3e..b5d256c6 100644
>> --- a/common/utils.h
>> +++ b/common/utils.h
>> @@ -54,7 +54,10 @@
>> =20
>>  enum btrfs_find_root_flags {
>>  	/* check mnt_dir of mntent */
>> -	BTRFS_FIND_ROOT_PATH =3D 0
>> +	BTRFS_FIND_ROOT_PATH =3D 0,
>> +
>> +	/* check mnt_opts of mntent */
>> +	BTRFS_FIND_ROOT_OPTS
>>  };
>> =20
>>  void units_set_mode(unsigned *units, unsigned mode);
>>
>=20


--aCLcYCY5nVeVZYqYiaPjJI4WSM6ZGAK8V--

--c6oGQibLfPNlptT4Lma0r144YJugWJOW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+3gZsACgkQwj2R86El
/qiP0Qf9GMgRu8GBCZNtVC5RXxtnPSYsC9/PlO932k+h9kwx8g8LWmtKtDgH87IR
rq6tkvDiU1u30TT55b64JtRL/gpTVzvvBR/izDHv5zKd30t+LeskPq7D5PmJkDE2
U7S3fSxAbUWpEDMQA+nqEur34ytXHJaMP9ZvEQ0AvKhAMzrn1pa0Biu4U5XCcDiJ
DpPcuHfd8s9FQHMli7un9iOr9stIxI/T6cP/dM2S8g3dhjSDFFzZav40uMHqX33p
TjcPrqku6G0JR9WkkDqWBMDY79GG3kKOL4oQXJhaZWQ2gD54NwWgYNaljFFSqsGc
EGzJ+MFJGabN1Q5+6kkquV0yLgBYUQ==
=DFZc
-----END PGP SIGNATURE-----

--c6oGQibLfPNlptT4Lma0r144YJugWJOW7--

