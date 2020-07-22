Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E07229AB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgGVOxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:53:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30345 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgGVOxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595429634; x=1626965634;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6C7RnryBwan9SeBRVURJTMvOYmgz5XoWkd1cJud6le4=;
  b=khD2AdOF0KyZShCqSxR9+x7CppAliWsCJpErMhbFIy50HrzWwlgo/xR/
   rqqCsanDZsy0/m3bPih8OZSTKkmTonGXBjQkvzi69UAIdHcE+LH+yF9e6
   FVGatQwVxtC07PODRIxTpgWS37d6RT62qjh9r8tSo+PNgK/MBWYbKsYW1
   dgxnm7eD5W/1HF3dgCekb/WV8MvTMXE+Bp2ZjajA66v5QkfgQB4AZKFYy
   QTGBb5AU1ZnCSwNu6gCvHjGMtCsDetPpwUNLoOM4/wJQhCsjepthmhGmc
   zHVVfvRbZTcySlIqH+54qE95wnkNZYMSLvLMeaVju+cwJ+j+qAi0rHrrT
   g==;
IronPort-SDR: h14eDNs3T1s4fRccLh7IY7kUsqdM9mSdjVNDRfQ04IyrGfCznFzpRcjlPhYquLcSZI6yxhZtty
 zX2l/H1qYtE3L7a7MC4CjwERfZXGTOoISpxwBqT8cqmkalyqEsCsswn1oYwOWOLui53vl4eQit
 SES5diMSiWcG2qIdT2rleryTpDz49/f0SiggqzExp7g/JLDUX6m9YLMJFYcFlrgwTWE8iCHKQc
 EV9FN6DI6TUIN7D0i/sa8zvfLI+/fvW4N3Gl5mv70jkWINbkIndkVFRWt7JAUl+eDd4VyY5/0v
 0N0=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; 
   d="scan'208";a="144384805"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 22:53:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmK2oHY/2icw7JoH8pqapUJOt+YPXISYw+ZZZYPEOHnq4ZP+D9VA2oq2vJwj1Co+lUcR65h7P5Hj7QgQa6xPd/NLlXc7vuNwfvfPrmVlDwzqp5XIVhnxzcuwUByUE0yLyXLdrTuQ2T6w/Y9qn/U2ojiOYPqygK5JXNfRdrIDVW69AsagKtCbkDiW4GAR2BzJNxepXA/js/vUlbBLPNMUI/yTMgapg5Zt18X/nnheQGls65urZeuD4xKW87mkgx9SAAIBeKUs/n+emIVO9I7iRflvGJLvOaJ49zrNQo5IN4CHKpWeupWOAjiBerPZnDZhCGLoTCuywqcdzJnhLYI/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azvh8inVLlnUIk+87+Ss0gSU/g843mnXCVjbaNKbG3o=;
 b=gVutwxyIvt5n3FqWZE4E2jniOGtaBDndcEnZj+F6cOzJKtWBzKSEfALdpbEMdnYI5/eiGDGqpoYf2wt3VfCYHfJ981vaceeGhT73BXrmv0s8sIhjLInSaFkSME+PmYUKe5pl5aqC7hQ/+toWSmteRhZ56MSez66Tn8qt0kvHnZeBuqj9MXGRMFgwZqg//7cplV9AQ2hsgCZ9vhYm6WfFcwCM/E5jZs3MI0jlrSjjB7GP4vh/T+7Gh2GUfX4eAN86cTJPvaxZXV9+8giZxAklwPDzAIvCK8un8PGLX4F53sszo2F3E7i6arSBT6NvCqlTJCxlJ3PJrg98c/jG1sefkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azvh8inVLlnUIk+87+Ss0gSU/g843mnXCVjbaNKbG3o=;
 b=ei8lACEOeo8Q4Va886JSLQs73ulrSeMRIpbyDctgOHvij1cskfZYTIsN6DIb/u822EknPauv4YLiAMhL4/2teib4BAPyfPljN5PKu4Z3ofGAyrT8qe3Igwb7kxn1fx9NG4B0TWZ9ZeU6duE14ti9b9iPn/7h9JaU2j605wijVsM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 14:53:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 14:53:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: Use rcu when iterating devices in
 btrfs_init_new_device
Thread-Topic: [PATCH 1/4] btrfs: Use rcu when iterating devices in
 btrfs_init_new_device
Thread-Index: AQHWX/9xTLbRR89zDUKIQqG0qAcugg==
Date:   Wed, 22 Jul 2020 14:53:51 +0000
Message-ID: <SN4PR0401MB359831E99526FFD5E3546BDC9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-2-nborisov@suse.com>
 <SN4PR0401MB3598E3FEB988273A2709414B9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <f8a7bab8-98dc-55c6-5adf-7d0ee95bb3a6@suse.com>
 <20200722144750.GY3703@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b299d6b9-0397-47bf-5b28-08d82e4f0c72
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB3597C8AEE85AF13121231EFB9B790@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lg/N+X/g35UTNO43btfeSHbO24ypa9Ct3AwXMgSzCyBrxJrjzQ7aY6ekrpf3CIZkrEVJMhJqFEShmOWi0UxmkH72Cn8BruLOVKpDh2NmgCyUuTB8Af6DdTHJWu6Hu4wXtwS+5QlPrW1zWw+pVt57K99epAGOeM57Y5Ik5faRuTmfZzzieFNe6O803n5rUi/Nxon/DK1JGBb6GV+HuRsnD7b7cR7diLfkIWSUyp20Y3B+SrapMjB0QUC/8rV5jZYT01VQNp9e4aL9r1JTwBaBNWLDwTcg1ISSPcSQ6kXCebBcML0nEcIyua9qPqj3sBJrbK/Po2xgwv3Fr8SwlWLDoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(7696005)(52536014)(478600001)(86362001)(316002)(71200400001)(83380400001)(4326008)(110136005)(5660300002)(26005)(53546011)(6506007)(66946007)(64756008)(76116006)(66476007)(91956017)(66446008)(66556008)(9686003)(186003)(33656002)(55016002)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aPNmwxuMw0Mxo7K4k142bjNkE0jpoPNCH/Oe+uuNyMAMo+mB7rbznq/ljCRFg3auKUh5OCIipoIAm7ehvu1nunft7eEv7KIFjghdGt10t5Au5Zuy4BTOyPDM2eyGEGseA6dtmkDa9IRXep2QHtVlOeo9QojwaAe3EMr4MPFSmG1RWjQ9hH1gCJQ07/mMoSZS+3mChQIQxP9Ry711sAYQsqHp7bSO/wmy5PgIpZa12LKJYtFLvcu0DbTD94DvbjzEwgIn/lNBci0WDnkoJgLXZUcVR5xkMhot0SU6+k7OWKL6ZXv/9nhnNRvdmVOiIF436nOt03bdof+gPnx5zds3pYulO3OmcEQC9LcIZH6ktOHiGd//Sk1aRlbW6n6KfRvzFY4T6TMoR63fvLYASrO01iGkYm0vGrAtNobNrDHYVQg88O+Q3Teko9nt0wH/CKjQQBBC/L5BZ/AthfUu+RAZ6R+63Lp8WJIdI55m9pQ8rWdZx3KjMeixKA+m9S1N5t1I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b299d6b9-0397-47bf-5b28-08d82e4f0c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:53:51.7511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmxkwlsCq2GlxqQ4pvoLVjgPd/cfUFF9XNqqUU2rKgbmarMaQdsgtjRqSr+dOzNCzzy0XuFp7TismEb6HxBPKlUNZwLbv9Q/p3sr9ZzMSZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/07/2020 16:48, David Sterba wrote:=0A=
> On Wed, Jul 22, 2020 at 01:36:15PM +0300, Nikolay Borisov wrote:=0A=
>>=0A=
>>=0A=
>> On 22.07.20 =C7. 12:17 =DE., Johannes Thumshirn wrote:=0A=
>>> On 22/07/2020 10:09, Nikolay Borisov wrote:=0A=
>>>> When adding a new device there's a mandatory check to see if a device =
is=0A=
>>>> being duplicated to the filesystem it's added to. Since this is a=0A=
>>>> read-only operations not necessary to take device_list_mutex and can s=
imply=0A=
>>>> make do with an rcu-readlock. No semantics changes.=0A=
>>>=0A=
>>> Hmm what are the actual locking rules for the device list? For instance=
 looking=0A=
>>> at add_missing_dev() in volumes.c addition to the list is unprotected (=
both from=0A=
>>> read_one_chunk() and read_one_dev()). Others (i.e. btrfs_init_new_devic=
e()) do=0A=
>>> a list_add_rcu(). clone_fs_devices() takes the device_list_mutex and so=
 on.=0A=
>>=0A=
>> Bummer, the locking rules are supposed to be those documented atop=0A=
>> volume.c, namely:=0A=
>>=0A=
>>  * fs_devices::device_list_mutex (per-fs, with RCU)=0A=
>>=0A=
>>     18  * ------------------------------------------------=0A=
>>=0A=
>>     17  * protects updates to fs_devices::devices, ie. adding and=0A=
>> deleting=0A=
>>     16  *=0A=
>>=0A=
>>     15  * simple list traversal with read-only actions can be done with=
=0A=
>> RCU protection=0A=
>>     14  *=0A=
>>=0A=
>>     13  * may be used to exclude some operations from running=0A=
>> concurrently without any=0A=
>>     12  * modifications to the list (see write_all_supers)=0A=
>>=0A=
>>=0A=
>>=0A=
>> However, your observations seem correct and rather annoying. Let me go=
=0A=
>> and try and figure this out...=0A=
> =0A=
> For device list it's important to know from which context is the list=0A=
> used.=0A=
> =0A=
> On unmoutned filesystems, the devices can be added by scanning ioctl.=0A=
> =0A=
> On mounted filesystem, before the mount is finished, the devices cannot=
=0A=
> be concurrently used (single-threaded context) and uuid_mutex is=0A=
> temporarily protecting the devices agains scan ioctl.=0A=
> =0A=
> On finished mount device list must be protected by device_list_mutex=0A=
> from the same filesystem changes (ioctls, superblock write). Device=0A=
> scanning is a no-op here, but still needs to use the uuid_mutex.=0A=
> =0A=
> Enter RCU. For performance reasons we don't want to take=0A=
> device_list_mutex for read-only operations like show_devname or lookups=
=0A=
> of device id, where it's not critical that the returned information is=0A=
> stale.=0A=
=0A=
OK I got confused by a) the mix of unlocked, device_list_mutex and =0A=
uuid_mutex use and b) sometimes we use plain list_* operations and=0A=
sometimes rcu list ones.=0A=
=0A=
 =0A=
> The mentioned helpers are used by various functions and the context is=0A=
> not obvious or documented, but it should be clear once the caller chain=
=0A=
> is known.=0A=
> =0A=
> I can turn that into comments but please let me know if this is=0A=
> sufficient as explanation or if you need more.=0A=
> =0A=
=0A=
This would be great yes.=0A=
