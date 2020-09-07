Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB23525F970
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgIGL3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 07:29:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10466 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgIGL3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 07:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599478161; x=1631014161;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E2Im37O8seYELRoFynCA8Uc5gRxzyAc1FpHbwKU6TLw=;
  b=qRBvOeGbH7MJKp/Z1krTU1t44zVY8kq32A8Q8S6JT1SJwz5lmFjaZrEF
   A1w1J5zq9mszJPcjJrmxdI5FkaK3O+nvEsfoFuzJfMhJr8RrdVWOEwsNA
   TER72iJxCfBlkm4GpCUNk4v3UMUtJ3XjglFeT9fM8NKQuHZ9T/259S3wQ
   r3hq+IlEmIVdL36S9CdUCf6Ml5dNIpiZBzia/ao8fsP1elon4XT6NIIl+
   erlt7IHrwQxA/2Mr/08zLOVsZuyG3n5bR9X+nME4mFCpU+v2OYgHIJpte
   XzUUkzJ5QTrxq/25ak5kEUrB8jPatRSSWR+fxbH//csImNmFMNWN/561y
   g==;
IronPort-SDR: qw+Nh6/WDJHq4rLq110gQP0DolcNiNA0k/sltBqysSHFX8W9w/F/f/lUfdveViu5+dSx9BoSj3
 dehiKVqYpnR6g7XFtcl0sS0JeKV0BtzkVGAcY0ApHqn2DafY0TA4LWs4tgkgkfUOz8RUiraDJz
 mR0EQ96BZ80HDEOyH9sgsXIEFSxl/uw/iW5LY5npXHwyBSaCcnW4peML8bsABlHG5dv2IhcXa3
 81InhpYReykwYyExWk4cpwOS2Fgy5OoSI5YSowLOR17O6dNcbJCSSw271NVk073H++8fD3ZAww
 uyg=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="147961074"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 19:29:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/wQj2MyZA80F2mog68LCptFlMuvp8pkfnZBTaRBTn8fp9toolFs/NdvkpOas64gmA99jHB6tplPgKy6hJFu79HnvToLNwjsdwn3wEZ6W9T/cq60q8vABjUowQYfxznFcSDrpCU5k1mNCJhYcYZBmcD00Utxnh7TM6GJ0QXf57P2XNkxrb+qXxjZ0O6IHmNRZv8aDQ5fjwR4+4UG8OaT5q7PVI5Q150cdvXTlF8Cfo2zWAT7ZnouIWTdQ4MhELwc6MXWNboLexoWlbZiOctONmAs4y7AfymcPozGJ/sueT3pGgIa3m17b9ymn5lUqYPjigp0dMVXzLLfSOndXaxBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYvmzyQaz7oQt8FNyggrmvrNrPAE5wjai0tKbd+ukMQ=;
 b=f3zAkBVcPIyvPGH0VpKkMMytCgbH6LLTaWDST65d3zJitwj/+1J0Btio5ekFYcC+M5i0qkktTCYh1wmbsefFBoP91PAHDtW3n0QAQu6+/uwYWQ4WNK3EmVUSISV8PzlViH5zsLmxClV9U2xvYRdzCyRXMvcT7BsF6tk4ikO4D9zepBQxiHy2GQuQiIUwB2eUs84OxgDfS4SpUXqb6AuXAdlwMw4awCADpBNUodBP7sJAQNoWz0b7r2JiIeDYxf0BzlpadpWKLc4Ed0Q0e9K0FcHfiUwfjeYKdfBux++SqJojN7hadg0YRybb3pTvt4GmbyYdekBt7JC+3AcQoMvfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYvmzyQaz7oQt8FNyggrmvrNrPAE5wjai0tKbd+ukMQ=;
 b=E8j9/SDUnl6s63cfMfLtqUUqZI/DJXs+TjkBy3Omx1art0oIwwUN00wOlW/71TZauon6+vDtLuUV/HY1UcuQsJcSVdjWCboI//3zMFdUPMrs2hyCT2VTR/1Hx6xRBkRAeezDECBXftxCBGFFm0F11HTuE1Zaw/YMAncsgemNOBE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3888.namprd04.prod.outlook.com
 (2603:10b6:805:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 11:29:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:29:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Topic: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
Thread-Index: AQHWguIIkDqfUfIXSUOxSTuVxfYe9g==
Date:   Mon, 7 Sep 2020 11:29:16 +0000
Message-ID: <SN4PR0401MB35988315D6DF0068151AE2359B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf450ae8-9585-4c22-ce5a-08d85321412f
x-ms-traffictypediagnostic: SN6PR04MB3888:
x-microsoft-antispam-prvs: <SN6PR04MB38881CF69EEA7D93B481FB3F9B280@SN6PR04MB3888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iShj+Od/e7Ux5AKy1eK2i1nO8OYMbx6c8bwGx72goEPTrUbvKP6EQ6bm4pjr2W/g0yHV5recm6PseMSpPdFUH9FYPjcFzo+jySQhTrM2yUNpeP8hAdMI8ZX4NrxQ47XUyBgTvhwSz2FteXFlM4gGpTMoGj/31xc++FuUMFJj83CgbAGOX/qpKQ3B4CtwoiXVacbSdzV3ztoiyA9SchEEMReV9RKy+BpZV7snGVrAU4d9LSQzLAd6YeSnc0jKVo2TADPRwdZbnQslOugCoPt2k+7muzDLgJCAg7CDW+BFfXdiW/T+oe+CBqrhsBBhzAN02CIVDF6X7VztX96lf+s1PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66946007)(83380400001)(66446008)(66476007)(66556008)(186003)(76116006)(316002)(91956017)(478600001)(8676002)(71200400001)(86362001)(5660300002)(8936002)(52536014)(64756008)(53546011)(6506007)(33656002)(110136005)(7696005)(26005)(55016002)(4326008)(9686003)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9L0iSNgFrYRB1zrnb5f1kJq+XkhyHyjwnam+b3J5K13lpjrWZ807BwIMI15eTQ+l/mBjE0P5SdGqxnSuCuZIS53kLWpTLiKQYhHDgVWSCPmW0iHoyw+qS1dAxYA3zFDH4oBZsrrzj3AsqiyppYi5iu+H5LKx3m7ypxMh7ksawP6ulqAK+4NlG/Nj7tMviF9HsltfnugusSKeHILYb8dO48L6DB3qtg7tggMGD49CKDTarPG3XNRqUTrredhoYYfQHX9Y2SgWZKfEQTsZZYFc09ysng4LrDyEqVHodq/V30OzGuJHw719uPglw0ea8bCgtIgkCgxCHP/TShmsPemWvj4uuRJQ2nw3iM88aQ255UvDjTboTAAdm+PbcJvpamso2EeUzJq1xznBVcjj5dJuYoAdgfkxdgJePhGEbgl9H2YDjmuRcu/kT/9rIf83uS98k8BmashvpodPIKGhls6iW2fwB2FVkn/cjWzRb2ravVy9Rw9xJMKux+V6nAumPy+M1OVttd28ggTJldzWyBxReY0yum4MbEehDsaNPQobAlTQXPZJxnxUprUf9K4i8DaVmHC6xB/4wFHyrZpXHpK0krgN8RqnSDtFnw3c3ZwaaImlDNzov4jyXyfis3SlGakJO8GTVoHn6JRLiPa2O4lgog==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf450ae8-9585-4c22-ce5a-08d85321412f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 11:29:16.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxHnqjoyRmR9i4Exf9XNaDlFwV/yRSr8DTreKFAhwGi5OMCgAfcx2xICjGCMDUUVCPJD+TB+BIjQlnCsnMqZ8CPSMBylyVVv9tDEXC4o6mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3888
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/09/2020 19:37, Anand Jain wrote:=0A=
> The following test case leads to null kobject-being-freed error.=0A=
> =0A=
>  mount seed /mnt=0A=
>  add sprout to /mnt=0A=
>  umount /mnt=0A=
>  mount sprout to /mnt=0A=
>  delete seed=0A=
> =0A=
>  kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_pu=
t() is being called.=0A=
>  WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350=
=0A=
>  RIP: 0010:kobject_put+0x80/0x350=0A=
>  ::=0A=
>  Call Trace:=0A=
>  btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]=0A=
>  btrfs_rm_device.cold+0xa8/0x298 [btrfs]=0A=
>  btrfs_ioctl+0x206c/0x22a0 [btrfs]=0A=
>  ksys_ioctl+0xe2/0x140=0A=
>  __x64_sys_ioctl+0x1e/0x29=0A=
>  do_syscall_64+0x96/0x150=0A=
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>  RIP: 0033:0x7f4047c6288b=0A=
>  ::=0A=
> =0A=
> This is because, at the end of the seed device-delete, we try to remove=
=0A=
> the seed's devid sysfs entry. But for the seed devices under the sprout=
=0A=
> fs, we don't initialize the devid kobject yet. So add a kobject state=0A=
> check, which takes care of the Warning.=0A=
> =0A=
> Fixes: 668e48af btrfs: sysfs, add devid/dev_state kobject and device attr=
ibutes=0A=
> Signed-off-by: Anand Jain <anand.jain@oracle.com>=0A=
> ---=0A=
>  fs/btrfs/sysfs.c | 16 ++++++++++------=0A=
>  1 file changed, 10 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c=0A=
> index 190e59152be5..438a367371c4 100644=0A=
> --- a/fs/btrfs/sysfs.c=0A=
> +++ b/fs/btrfs/sysfs.c=0A=
> @@ -1168,10 +1168,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_f=
s_devices *fs_devices,=0A=
>  					  disk_kobj->name);=0A=
>  		}=0A=
>  =0A=
> -		kobject_del(&one_device->devid_kobj);=0A=
> -		kobject_put(&one_device->devid_kobj);=0A=
> +		if (one_device->devid_kobj.state_initialized) {=0A=
> +			kobject_del(&one_device->devid_kobj);=0A=
> +			kobject_put(&one_device->devid_kobj);=0A=
>  =0A=
> -		wait_for_completion(&one_device->kobj_unregister);=0A=
> +			wait_for_completion(&one_device->kobj_unregister);=0A=
> +		}=0A=
>  =0A=
>  		return 0;=0A=
>  	}=0A=
> @@ -1184,10 +1186,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_f=
s_devices *fs_devices,=0A=
>  			sysfs_remove_link(fs_devices->devices_kobj,=0A=
>  					  disk_kobj->name);=0A=
>  		}=0A=
> -		kobject_del(&one_device->devid_kobj);=0A=
> -		kobject_put(&one_device->devid_kobj);=0A=
> +		if (one_device->devid_kobj.state_initialized) {=0A=
> +			kobject_del(&one_device->devid_kobj);=0A=
> +			kobject_put(&one_device->devid_kobj);=0A=
>  =0A=
> -		wait_for_completion(&one_device->kobj_unregister);=0A=
> +			wait_for_completion(&one_device->kobj_unregister);=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	return 0;=0A=
> =0A=
=0A=
Hmm this is a lot of duplicated code. It was before as well, this patch onl=
y adds=0A=
to the code duplication.=0A=
=0A=
Can't we do sth like this:=0A=
