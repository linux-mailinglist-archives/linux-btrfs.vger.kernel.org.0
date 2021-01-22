Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48D300356
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 13:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbhAVMjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 07:39:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28293 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbhAVMjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 07:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611319173; x=1642855173;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AJ9dD+heGP4xGat8XJbFcqWgbkOLif0e/m4AZMRVuWw=;
  b=TxuT7aY8KWOtVSnVAKyrEFPfSP/ZsezAJNwVuouPeq/DlkuoF/PIYi41
   Yk20C77CGI5EhaqtZmdl17MyqzOxK6eyIeaLpw2Vozs63hdfU0F+vjHJg
   UsOS1XkrdNy5DCE2wPnIgJYLJ/x0MMfRZZ2doAMN4mPKCbUl91gr+jpMo
   VRDSVwiIoLMC/AtSNd0ganNSqumvwGhTCszWgYgFf61mXQ5XGGQGsKY0n
   S6zyR71C0nNH/g7oZihYKJSzfpkOEt6vGz6EBx456pfrH45GW9sK/cwa5
   c8g/F1sFrceSwKVQ+vCs3EQYyJbw/1O0mHOrkUMfXx8y+NH5DuGaGQWk6
   w==;
IronPort-SDR: 66vgF8Jwb3r/Mw2jyfcRMpv/JVct6vwWN554XD0GiepJbgcCO6LBhrfIwqwH0qSD+tWLK/skf5
 Oo5csOEQKzX3oyh5JMe/tdHLiaPmrjpa1UowRQhWyKzwz727D5v4qJkhMlGVY69VA/v6/SoiG0
 yQVXpKQ4X23fuSD1yQ0HmH0smYKz9Tdfp8W/fJE5xnR2sEP48cuDNUjgKBDyqDttM9+UFTT+0B
 vc6FsG/TwhAQSXkTyWey0DF4kstAzTHuLuwd+1xcxq8qqGkpgv/p9lIHyvc8jo4DIhYz1q93SC
 KOU=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; 
   d="scan'208";a="268415562"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 20:38:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFdwCMyrv3jvp3IYrzKNnVq2dG70fsrSqNZ7ueZg9EYUN5TnlNPWvjnLfjJZuLHxi1iBAtq05M1harOMXwz0aO1sKlOgYYGBTkosf4Bum11PSq7qR9YVhp+KcOO8TNdz8Mx73T6kjM5WuY/9HBlr9POYoG6yC75pVHwd0f7ww8ejH7Hp1O1kmLBcbhx8vt9BcFzPaU6BBVFqNt7atTyHFLJrCq1aFY9kjIKNVDwIUyi8KPvXmsr8sdpQjNh9g6OG8R4KeE2PqqtW+R+D4rm76RKqEXeHzEZ0rSWWujDj7Vl2KW6QKSbKlqG9JnSNsa+DTdJuxHWz5iHFOhMNino6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRkTGqcx1QSSHqDyY0C5lSZi1OF9PRFTgxXha7rGsYY=;
 b=jbvE5uUaQccFbgz66uCKRFedvQRbSF/6d8M+MX358SZy1CSjOXqLWHZqiNJRCZPX/wT/AD85/iqCJc01QO4zo7XX6I1P51Pr05hJ45XBZqTCDpmBN5iQiD6QSlVvuWs7boH8Hi8hsR8FolyqJp0wmB7HFccTMFS8TMBweUgZfiS9aabUGG3JH+E14QKtWROGNBggKybxfhm5owZXNb4Cg3q2XWar6NBQ5YZPHx3U7wcBmLiZME5JOk4hfqI6UfcbxpVjF3XtDroYRtdetdizLQWqgJd0SkubtNsv/Exx+jeHXWKG1x3+3xULc5K2083ZBZJ32HvDliYa4kxd4wkEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRkTGqcx1QSSHqDyY0C5lSZi1OF9PRFTgxXha7rGsYY=;
 b=RSORxYJ1+DquvZvDAh9FzkgM+zIYYM5Ywc55SnuHJv9Hfyu1kcZVtsZl46/2JM2VURis76Ed3aiJGraRCeoAivlLe9KojjfgsROvCWhokkuddzkEJYWIb+l8o06cz14Qta8b6Go96+HMOKNuBK5v9qBbkzNrlSSp44DqnXeY0jU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 12:38:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 12:38:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 03/14] btrfs: Fix function description format
Thread-Topic: [PATCH v3 03/14] btrfs: Fix function description format
Thread-Index: AQHW8KfCcHFSTTlP/0KiAiG7bHU6Pw==
Date:   Fri, 22 Jan 2021 12:38:26 +0000
Message-ID: <SN4PR0401MB35985C0989FAB54EA9E0520B9BA00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:4cc:4501:d881:6dc:68d2:9b00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b1d7bba-b656-4daa-28bb-08d8bed29dad
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680E5626CEF417302A461359BA00@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6GlTLZvbycT7gS9BBfmnzS7adcUyy7y263N9xKyQ6BG5SA0H60S+ghW54ZO1DMDmqZ+ElakLUZpIge9DPJC4EJRhjVmstAnucULNPtZQAG30KSAGlg7xcZMGqd98L2C/iMWjP/w3EftbzOryjleCug22gI7m81EE74CEx5hNQninPtvLe0BY+ev9wX4NfQfaWhmGHi+8YfXFUJBKJ27satO+/2TEe+TTgZmMH94WreSqIyRRjYbKFjsKIP5Ly2oi0XsZb8JLXoBADBvoT5U9z65YuaZbI6J9xDCKdpLtvf/hcy0SA/NKHM8Pcml5ykob3ByUMMxE3Odrjs0lRimZwShqZaaf5tarI5h9gT2Bohm5Fn7QZRlBSf7UXFVXKrWYFxK1SfWGPM3D64rNpXyJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(55016002)(8676002)(2906002)(8936002)(91956017)(478600001)(9686003)(71200400001)(53546011)(64756008)(110136005)(5660300002)(6506007)(86362001)(33656002)(316002)(7696005)(66946007)(52536014)(76116006)(66476007)(66556008)(186003)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M9X2hZNoxq+8H6WCssZUwEEvdVxZOH5B9FLUGB0fHU56LF6KuRqunOfai75n?=
 =?us-ascii?Q?iL5nm8rilv0q4g9o/6SXfvw24Yqg3V6CcSz5TlmYmr9QDWvDtskilJQGzJua?=
 =?us-ascii?Q?/p9wCxVFn3J80wZGL8E+zKL4RBXAtPKaYEe3HttYcNnBnrsefXXLxosG6Q4w?=
 =?us-ascii?Q?Ew2STiRwGILfKXZXNRJYk6cKEALrppi+YBUfwBcHl7VTN/DuFA7YVMQVB70f?=
 =?us-ascii?Q?Hfll6AMP1f4uHIieI2yB5StaouQSSK/661bML0S8R/crWBN54zJldP5QxE8J?=
 =?us-ascii?Q?EPUCVdtjZjfp7MaCfR+x/kygl0ZbjR63pqXWt+TzRTr7KbJQIuWj0Bs4jJ/x?=
 =?us-ascii?Q?OR/WwsNCeGCBPvSJxU7l3A2C8D+dvVtZ+e477qBN4W49BMEqudyq5CgPSNTq?=
 =?us-ascii?Q?RoI3sAJiW57Rc9IWaozEBTDNmIIkXfrq7k8Z72B0Y1468GF927to7jn8Qxlj?=
 =?us-ascii?Q?CM4tV/e4z7vtoHVc0Ll3GS2FjhX7jVHXUr9azOOivWcnl2GmpKr7j5tKaa8D?=
 =?us-ascii?Q?i8Pv+VVbgD2/WHUjOK8HbOI6Nxzw41UFeNkU7wDW2qzyDOwix4mWL5q6Vjyu?=
 =?us-ascii?Q?KDQep7LGoKzaxEtqKZhHmin2ht84V5nGqvp/hDzlv1sGHcTfCU2u9846TWWI?=
 =?us-ascii?Q?/UXTkT5vU8xFoV7Ys46MwuhOpBEN1ia5TxJpUJLFywExGUlPhtiobY0YvndL?=
 =?us-ascii?Q?WxSdBsA8AThOItfpfWQTfr2erLgD8tSR74wyir9YfosirzmSVOBHtKuoKoR0?=
 =?us-ascii?Q?LEcqYj+w5YJL4VczUz6TrsUHJMgHtE+begwPzrn/sUYV4vYv3WKQMLgmNL+R?=
 =?us-ascii?Q?staYQD0bSKXA1pmexdQLMvtKiqzWCOr99cGj+WinUWRgalVnXQ/ZFktxVgvM?=
 =?us-ascii?Q?wCPizRkff3hwt/xR4jMqWvnirsuq7XQwcxR6fz0oP8fiDIlTsVyQMIPf6Shr?=
 =?us-ascii?Q?NYGRph7zP3s/o/MY6pqcbq1y+8r5l1HbmhRIm0Qj7YHU5NlfqIz8xaDvAcOj?=
 =?us-ascii?Q?RU1802R5eobHftrUXpYzmPl759LOaXYBnB+6K7djPRNfasISBWpkYXggavX6?=
 =?us-ascii?Q?c10KbRiV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1d7bba-b656-4daa-28bb-08d8bed29dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 12:38:26.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6gEvLlsTMMwvXV/ReeH0/u+VKvNpGvnVy+Qq8MiwPvncScFbkWdmTCaS+tmWkTp1ycCuD08eCyullNAeem2cq+JjJQavsbykmOVL5EdBC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/01/2021 11:17, Nikolay Borisov wrote:=0A=
> This fixes following W=3D1 warnings:=0A=
> =0A=
> fs/btrfs/file-item.c:27: warning: Cannot understand  * @inode:  the inode=
 we want to update the disk_i_size for=0A=
>  on line 27 - I thought it was a doc line=0A=
> fs/btrfs/file-item.c:65: warning: Cannot understand  * @inode - the inode=
 we're modifying=0A=
>  on line 65 - I thought it was a doc line=0A=
> fs/btrfs/file-item.c:91: warning: Cannot understand  * @inode - the inode=
 we're modifying=0A=
>  on line 91 - I thought it was a doc line=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/file-item.c | 22 ++++++++++++++--------=0A=
>  1 file changed, 14 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c=0A=
> index 6ccfc019ad90..784adae2d0f9 100644=0A=
> --- a/fs/btrfs/file-item.c=0A=
> +++ b/fs/btrfs/file-item.c=0A=
> @@ -24,8 +24,10 @@=0A=
>  				       PAGE_SIZE))=0A=
>  =0A=
>  /**=0A=
> - * @inode - the inode we want to update the disk_i_size for=0A=
> - * @new_i_size - the i_size we want to set to, 0 if we use i_size=0A=
> + * Set inode's size according to filesystem options=0A=
> + *=0A=
> + * @inode:      the inode we want to update the disk_i_size for=0A=
> + * @new_i_size: the i_size we want to set to, 0 if we use i_size=0A=
>   *=0A=
>   * With NO_HOLES set this simply sets the disk_is_size to whatever i_siz=
e_read()=0A=
>   * returns as it is perfectly fine with a file that has holes without ho=
le file=0A=
> @@ -62,9 +64,11 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_i=
node *inode, u64 new_i_siz=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * @inode - the inode we're modifying=0A=
> - * @start - the start file offset of the file extent we've inserted=0A=
> - * @len - the logical length of the file extent item=0A=
> + * Marks a range within a file as having a new extent inserted=0A=
> + *=0A=
> + * @inode: the inode being modifying=0A=
=0A=
being modified or we're modifying=0A=
=0A=
> + * @start: the start file offset of the file extent we've inserted=0A=
> + * @len:   logical length of the file extent item=0A=
>   *=0A=
>   * Call when we are inserting a new file extent where there was none bef=
ore.=0A=
>   * Does not need to call this in the case where we're replacing an exist=
ing file=0A=
> @@ -88,9 +92,11 @@ int btrfs_inode_set_file_extent_range(struct btrfs_ino=
de *inode, u64 start,=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * @inode - the inode we're modifying=0A=
> - * @start - the start file offset of the file extent we've inserted=0A=
> - * @len - the logical length of the file extent item=0A=
> + * Marks an inode range as not having a backing extent=0A=
> + *=0A=
> + * @inode: the inode being modifying=0A=
=0A=
Same here=0A=
=0A=
> + * @start: the start file offset of the file extent we've inserted=0A=
> + * @len:   the logical length of the file extent item=0A=
>   *=0A=
>   * Called when we drop a file extent, for example when we truncate.  Doe=
sn't=0A=
>   * need to be called for cases where we're replacing a file extent, like=
 when=0A=
> =0A=
=0A=
