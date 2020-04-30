Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D728A1BF9A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD3Nho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 09:37:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27414 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgD3Nhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 09:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588253869; x=1619789869;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kgMiuimCUWLk8KVKgbw8Warz6fWZhHJyVY2rSHARdio=;
  b=DXSC+Md6vhptlO4GPH4QAPk2UF5RfCNnC2Tp1Tvcj2jOZsbJk1kvUpbK
   iH3anN11ZwGe7iQHCJ0f80yMmS8kGs4zwfxjtLxpn20t30VFdg8EN+PKf
   1NpuDzF41kdg2A7QuFf9ND0hPefx1Lx9SsCc4oKrwCUrCGcRDuTIeYQW6
   hsjSS0TgUUahtranovZTruFhh/28awf7k75ViW0qjdCanepjqbBfG6zMa
   oN3xEIGJXrx7RPjAxc/91zEKqKQUayKV7iM6PACgVcbfFlTMi+IV7Tvj/
   VlUqjN8aDc3EaEyxnI9oHDI+nrfGq0vM6+6/mj3yqzp/g4FtA4YbYPbBO
   A==;
IronPort-SDR: X11OvWWsSDkshzT+prr+VLmoM8vaWNbzF9if5857YW9Y+wp85ui+4amkir5yVzVRhJpSt/7WcS
 6zyAgvmBi9D2/s11Hk91bv6YQ4XlX/llgtCRAeoIrwldZnk1hWGiMLysfU/oM6yM+Z95siQAk+
 3RrRD9Eudkk6++NXobDtn3gu+fPM8qEzOyRx3MW0N4lRzkNVygEIhTLGKsR5bKRXJspuPPUwgi
 bh+zCdgDp2kKM0WhoHguVMbPJb07beynizrl8wNU/DN0azHWZWyNk1a+eSEXzdQVtjsUomY7hq
 8L8=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="239139592"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 21:37:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGBZdzGWtY7Lz+r+nepq/hXxALHjmnT+tZp3AZzYSb5M8eTXCmf3CxgQs6AyqWGkuy7L5Bpu0GkR6JGG/IMRF4PYNmGoLm+jK5wYrZFfGoLdR7oA9NmVGn0X0jyfq9EIOwquSpHyfo5mwv6jlQurvwjoVMQGFhCM800aixDsSGPB93o7i9JsaeO7wA+gsgjIMC72+3xqGcSYYMWqNG/UoNiLKScD4BRqmZIf+5Fqug39nubK3u/P5WCXjzs6vsGs58TbeQNj9b40QgA33tns6iJKrUue8zJKfesX2EDWFjk8hq6XeLnFkEbDPxQjPYi+0rBNY+lraBaDZDYfPZX3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/la0/WLxzJI7PVWuHBfNcbwTKG6Wh2lyeq/HenjbK8=;
 b=doShcKsHDZ4rCOH55YmnZnP/OVR5+gq4JPOUaUUqxu402TnGSvJHKW4orvJU3ow6rYe3tQi2bwwsDjgOj3rXvn/Uja/oGHMPFg2rqYl4qKADlVKmP4CSI63Yi/Bc1qAmPquoopJ8ZfqEhKAyNyeBo7MtMFYVDstTXnDqtLeOJLs1a//LFSDxth5bCsZfj/IFEGxEnnOTntlzH/Wu3T7+N69XcWftEMdblYiTkza8UbSSxMJdC05ILj1+yZ06bZN3fFGcyWWOocnHBNToBP2KlWZ8yRoTJH0m1W/yMcQoggi1UB/C6dv4VJLf/aZmjcYfu+87/Z8BQMsimCuUWBbKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/la0/WLxzJI7PVWuHBfNcbwTKG6Wh2lyeq/HenjbK8=;
 b=ENDrt5fqkXDcyQ52BQOpfXVU4paIe1lpjlH+fpqmIsTuKLOJqCJomXRmbWEJUcu/vAHSaf78xDaL7EA2eEKM5rT6T+sSYsQXkFqA5zWAwZs4IHu0Napjd+MeuxX/bt6aN0o7GbKBtjZvKyQa0ZhNxc59oUqemok+fHcueJ+pP8M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 13:37:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 13:37:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v3] btrfs-progs: add warning for mixed profiles filesystem
Thread-Topic: [PATCH v3] btrfs-progs: add warning for mixed profiles
 filesystem
Thread-Index: AQHWCmxUECOJ6AqhdkysTLVR89jB4Q==
Date:   Thu, 30 Apr 2020 13:37:39 +0000
Message-ID: <SN4PR0401MB35985F2338F0F46A279ED5D59BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200404103212.40986-1-kreijack@libero.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: libero.it; dkim=none (message not signed)
 header.d=none;libero.it; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f7f9feb-91e0-49c5-fc0c-08d7ed0ba6cd
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB36306AB27713F2498902D5C99BAA0@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0389EDA07F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(26005)(8936002)(478600001)(55016002)(71200400001)(7696005)(8676002)(91956017)(76116006)(186003)(53546011)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(110136005)(2906002)(33656002)(54906003)(86362001)(316002)(5660300002)(9686003)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jP9+XFdjbOWEgGiLBpzdE0ke/a8rPYWFUdNa4a7Q1QmcrmhlEUfPrMeBoiWMBGV9HaE4sE0OgkDR+PpTEjgBs/xrZGvfKeLMWvisTMUjUfRN8ueSc2QXvFYT9oImNEhhHLw1PjYuimRkEZNkhGqSYpSOn3MgAW5fmlH37FHfgoO0ZkgBIEQ/TVRCd3CMW2u7mKJIW2zKYBGONSW9FociVpyxObcDn0L4bAxz4Nbne1HENmwJUK8vK5Sb6eHCcKZ12Pq6jweGe+RWtZLBZ0HfsmBKDlo8ryFweSV4+lliRLYLGfSGmpFLKSuma8EW+FCEG7yGTyut+yV3OFT3RQfdQz6MY1570t749lpLuimnvN/UvEdXzcXJVlSm4r30eJp3k0s64zKBYxlKpEJmLGsNS3qXy7t5CaKhhChV89995tj7NynIwOEOzDHExFQkzn0b
x-ms-exchange-antispam-messagedata: 7gJ4gSg63e9vPt8vCTn0hY0idiYgqwpr7A7JLK0a8DCoFeSZuhmqzUjxDFlQj6cUsht2IPdzJ8cQnRlynpXeZzwNAah9W+vUbdBs8FHoEZ9482Lz5Kd+VqVojbuBTc8cvEf0EULX99sXACZ4ppS6fUdKVEr9K/bcGQuz3uFa6WyfjhDKFYYltMgJ779QbHze4v27N9+xt4vU5kM9mJvzimDbGSRY12ZN5vae5Mc81qU6epvB3+mxfFFVBlp76IV+2X3sVLUMopnzeHfQ0LylfE3JHEbAhV0D2X4y1MiZy1EWbSsAYK6DLG7i79meA7ZpzpJLPbRg7rT5xeBqZe4W0u73bztOKUUaKgNozhBRkb0iKOs+u/Lwc0qWPAXxVwf+SVzpIE+NqRV/SkjfF0JtuyMNtdV2dtmn6Gkk0E16870DgYGQ5rGIT77310KWtr4lU+Lst0xBLD8zMpkN2RyHjvV4gSfMnIXTI45LG1dX6xaFtgEB306jlUM1Qb+LX5/HRqat8PPLmFSJ5td3fe4t7aYNASIgeNG107iAmv3NAXfkxxgdlDt+vP76TNYm39DUI8ZhZc8Wik+IdTTfnJC8SClYhtu+pHLNTLVysnGCv14BCJENEoC9p9K2tDwQ8DGxKYQZ1co1zKczy/jamcrgbwKCJG6OvbP2IrfHYIoRv3M29BhPN7cDdHyNb3WcNNEgodbZt+O4FaIcrPhKZfLGKBguUsF9UHp8WoQFI0EG/ibmG40qrC7/GjhbRLa2akhn9WDPv3Ke7Jh4zN4sD/1eAJe4rJkwMyukeJISRaWXbbg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7f9feb-91e0-49c5-fc0c-08d7ed0ba6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 13:37:39.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEHwxaW8cP7hbweqCsJHiLJ1/IlbATrKlo4Hy1zdzsigiCaU/9RIQVLbwy0RpS4+D6MV7HqQ/OcOI4rSuuekDDDLmiSt8mlvWrQnFc72z38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/04/2020 12:32, Goffredo Baroncelli wrote:=0A=
> =0A=
> Hi all,=0A=
> =0A=
> the aim of this patch set is to issue a warning when a mixed profiles=0A=
> filesystem is detected. This happens when the filesystems contains=0A=
> (i.e.) raid1c3 and single chunk for data.=0A=
> =0A=
> BTRFS has the capability to support a filesystem with mixed profiles.=0A=
> However this could lead to an unexpected behavior when a new chunk is=0A=
> allocated (i.e. the chunk profile is not what is wanted). Moreover=0A=
> if the user is not aware of this, he could assume a redundancy which=0A=
> doesn't exist (for example because there is some 'single' chunk when=0A=
> it is expected the filesystem to be full raid1).=0A=
> A possible cause of a mixed profiles filesystem is an interrupted=0A=
> balance operation or a not fully balance due to very specific filter.=0A=
> =0A=
> The check is added to the following btrfs commands:=0A=
> - btrfs balance pause=0A=
> - btrfs balance cancel=0A=
> - btrfs device add=0A=
> - btrfs device del=0A=
> =0A=
> The warning is shorter than the before one. Below an example and=0A=
> it is printed after the normal output of the command.=0A=
> =0A=
>     WARNING: Multiple profiles detected.  See 'man btrfs(5)'.=0A=
>     WARNING: data -> [raid1c3, single], metadata -> [raid1, single]=0A=
> =0A=
> The command "btrfs fi us" doesn't show the warning above, instead=0A=
> it was added a further line in the "Overall" section. The output now=0A=
> is this:=0A=
> =0A=
> $ sudo ./btrfs fi us /tmp/t/=0A=
> [sudo] password for ghigo:=0A=
> Overall:=0A=
>      Device size:		  30.00GiB=0A=
>      Device allocated:		   4.78GiB=0A=
>      Device unallocated:		  25.22GiB=0A=
>      Device missing:		     0.00B=0A=
>      Used:			   1.95GiB=0A=
>      Free (estimated):		  13.87GiB	(min: 9.67GiB)=0A=
>      Data ratio:			      2.00=0A=
>      Metadata ratio:		      1.50=0A=
>      Global reserve:		   3.25MiB	(used: 0.00B)=0A=
>      Multiple profile:		       YES=0A=
> =0A=
> Data,single: Size:1.00GiB, Used:974.04MiB (95.12%)=0A=
>     /dev/loop0	   1.00GiB=0A=
> =0A=
> Data,RAID1C3: Size:1.00GiB, Used:178.59MiB (17.44%)=0A=
>     /dev/loop0	   1.00GiB=0A=
>     /dev/loop1	   1.00GiB=0A=
>     /dev/loop2	   1.00GiB=0A=
> =0A=
> Metadata,single: Size:256.00MiB, Used:76.22MiB (29.77%)=0A=
>     /dev/loop1	 256.00MiB=0A=
> =0A=
> Metadata,RAID1: Size:256.00MiB, Used:206.92MiB (80.83%)=0A=
>     /dev/loop1	 256.00MiB=0A=
>     /dev/loop2	 256.00MiB=0A=
> =0A=
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)=0A=
>     /dev/loop2	  32.00MiB=0A=
> =0A=
> Unallocated:=0A=
>     /dev/loop0	   8.00GiB=0A=
>     /dev/loop1	   8.50GiB=0A=
>     /dev/loop2	   8.72GiB=0A=
> =0A=
> =0A=
> In this case there are two kind of chunks for data (raid1c3 and single)=
=0A=
> and metadata (raid1, single).=0A=
> =0A=
> As the previous patch set, the warning is added also to the command=0A=
> 'btrfs fi df' and 'btrfs dev us' as separate patch. If even in this=0A=
> review nobody likes it, we can simply drop this patch.=0A=
> =0A=
> Suggestion about which commands should (not) have this check are=0A=
> welcome.=0A=
> =0A=
> v1=0A=
> - first issue=0A=
> v2=0A=
> - add some needed missing pieces about raid1c[34]=0A=
> - add the check to more btrfs commands=0A=
> v3=0A=
> - add a section in btrfs(5) 'FILESYSTEM WITH MULTIPLE PROFILES'=0A=
> - 'btrfs fi us': changed the worning in a info in the 'overall' section=
=0A=
> =0A=
> Patch #1 contains the code for the check.=0A=
> Patch #3 adds the check to the command 'btrfs dev {add,del}' and 'btrfs=
=0A=
> bal {pause, stop}'=0A=
> Patch #3 adds the check to the command 'btrfs fi us'=0A=
> Patch #5 add the check to the command 'btrfs fi df' and 'btrfs dev us'=0A=
> Patch #5 add the info in btrfs(5) man page=0A=
=0A=
Btw with this patchset applied fstests choke on some tests (e.g. =0A=
btrfs/003) in my setup:=0A=
=0A=
btrfs/003       - output mismatch (see =0A=
/home/johannes/src/xfstests-dev/results//btrfs/003.out.bad)=0A=
     --- tests/btrfs/003.out     2020-01-02 08:43:50.000000000 +0000=0A=
     +++ /home/johannes/src/xfstests-dev/results//btrfs/003.out.bad =0A=
2020-04-30 13:20:43.050569551 +0000=0A=
     @@ -1,2 +1,4 @@=0A=
      QA output created by 003=0A=
     +WARNING: Multiple profiles detected.  See 'man btrfs(5)'.=0A=
     +WARNING:=0A=
      Silence is golden=0A=
     ...=0A=
     (Run 'diff -u /home/johannes/src/xfstests-dev/tests/btrfs/003.out =0A=
/home/johannes/src/xfstests-dev/results//btrfs/003.out.bad'  to see the =0A=
entire diff)=0A=
=0A=
