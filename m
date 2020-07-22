Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B3229A80
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbgGVOrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:47:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64196 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgGVOq7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595429218; x=1626965218;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+Yk3GYVoTHFvH+lt/Lwu5y/m4MTr8S4Gdp2lmsOQuDo=;
  b=hdiajg5AcDaAtVNVbrWQuwR+IBOyHnRMpWfZNqKWUQKfKtZkkmeiJG4I
   oZsuBcHmIonYni5sevNZQEGOlS9hr2w2XTb/A2NFSRHxKGZ+jmrAxz6hg
   uAQ5KaVz9YORfpg+z+YW+Px/RBsNSFj1qVQA9DvE/w7sQbIPU03YATOK8
   CaPId95jT5k0CsXYVZZRSjYImMqWb3p/fpkUJjh8icpHsmg/YVEAxjjcd
   uCTCFc+jSt9dGVfGvAFLXUK1AYFSKj+pepAFevlOuXVeX2tP0iWoEEYtL
   gZ+HKIhHeVb7S0WBymT5fZ81wHD6w9KRvajQ3OBz5mB1/uzwXrOWDzcdZ
   A==;
IronPort-SDR: 5UYMjqhH8hxDrE6SXd18sNA/jTOuj7v/i8VU0iDfmuRyRJtktWFbqp/xOJM41zSy9SjustCKhR
 UU2P2hUkh6AmflYinxH0HtBCSX5sFklvKhFS8RGyjMFD1/fd08I/YtxEzeeWSXH1xJ/0znBvs6
 v4ddgHJjrNR2i5GiH2KzgMUGFfZeMq74HvYuec2Ic7y1MCJWjezL2JPUn+TDAzOBCctIctxFnR
 tvJ53K7QkwGJraL+/qDJSGhPMozIUOw8PnRHP17Te/88kx/FjFnLuLlRq+4E1pIsyVRUxMFiGm
 QOE=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; 
   d="scan'208";a="252406684"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 22:46:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e35tav+yArnNKbUfeESnk6lxvuK1V+WvAY8pXYOjXzA9j4bZtPmhgxUwKfhgMqsR0nbnrnnRy+Zt3AOFjlMsbrzaktF5P0aSKxAgeS6fSe5awYJ8DDCgnQOSNbZhkm3Il/KYMx86vgTM7EH5u4n4cyd5QIWukzIMPT1DIH92P34aCrW+aaNLGA+gHWuJGvF0SvHXBIhoc+e/AkJImO+9a9nKf+AtHl0ex09+ASCDD7sOM5X8iVQlniH2XiVeBBdPmCYYdmu0KnRhbpc7TtMdNDCwUbpPLmC7JQasAkqxWXth//mzibAe917aTIBiFLen1oWL3sjzfXtZQCnQ+zO0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7Gy6lKqVtvQ0aAb3vYwOfPUzW8NUkPGgErbk71v8MY=;
 b=ip3qDfNsYA6fquNFotyszcUH7ZgLWhwKlLrbl6L5KIicPJ6+VHKnPd7ZvSWrKYAvcbI+bB2d3HVWKoIi1JjyNRvf/4miwx/k4lzTvn5eaPZZhz+WkfCSxK7MQ/oyUqETSbuNnw64mTOVN0ypY3jWi0wZ4cj2598EWDdDUw00ycflpwiIpcRbhNCDmx/WxPOiIg/MTTEcewpFSNJXTKvGcmy1ysWyCh/fhC/0SOOuo4GXFwA46r9DEBMsL/tZ/Vy+Ae/quHxij6ASMEWK0TSMshV8ox36BErLzgTdclOEVwuDcCDrGOAScmmwv5hzEgE8wruN3HjWsM4mEK57z2E0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7Gy6lKqVtvQ0aAb3vYwOfPUzW8NUkPGgErbk71v8MY=;
 b=q524PvVh9KOo5XcW4DlcHdF0mn6ebNMTV+UzjVEcuf9gav7P3vdqQj242xrTM4lu7/GcE3ZMn+RTYclYrCxXw4LEKY5530CwsL5cJUPrGFxIvstd8gNR/KnIQ6Uelmnn1ad5t2AGGZ0MypMVqlsbXLs35BnqkBdEcAfnT3eUXv8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 14:46:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 14:46:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Chris Murphy <chris@colorremedies.com>
Subject: Re: [PATCH][RFC] btrfs: don't show full path of bind mounts in
 subvol=
Thread-Topic: [PATCH][RFC] btrfs: don't show full path of bind mounts in
 subvol=
Thread-Index: AQHWX4si4Wwq+FTYikKHU8Yt70rxMA==
Date:   Wed, 22 Jul 2020 14:46:57 +0000
Message-ID: <SN4PR0401MB35983EE21AFAF0C20803CE719B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200721181656.16171-1-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 380ad9c6-f5fb-496f-dabe-08d82e4e1556
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB359727AB2B16E8D641E7FFBB9B790@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRYDI/BxjHNwkkrgvIPqhXReKGZWPYXTf2HlFV+rdMOn8lvxnr1bWZP1cHT2mS8JvCBRQviELqG6DSCEPXSLE9dK/4/B6IGCQrfmnrMBqST0e34WqYMtN3Be9ooRHezwFPq8VBeT8VbGVvQoTV9PzIZx/DV3g68bI6kBgKvGdQHrOuw+sRU39UZNKHlf7krAaEKwRhW0rxKLt51i3YAESBwG8HePQBAI4RhHh/qEm5aN/r/0vdCkr+vtVGYNkZifJBBe5Cgf6ep2gfA5x5w+1S9wxsRp9N6e3/5XeTH1orLgPj3ZpUilm60j1AB/uWHFA+zK+toUeBwdV1b7wwDeXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(26005)(66446008)(66556008)(91956017)(53546011)(6506007)(66476007)(66946007)(64756008)(76116006)(4326008)(110136005)(4744005)(8676002)(8936002)(33656002)(55016002)(9686003)(186003)(2906002)(86362001)(7696005)(52536014)(478600001)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u2Z0RCZF83RAT8Y+WmPwaqu17kyaQNSUN3HktmVhSnR6GKPRQGiFZwR+UD/Bh1RYXbqO5En4LIx5m5z4ZhOXIzRDBwtAiJGJIV2CbwuRl3w3WmXykyMQn5wb/nBukLR49RlLGHK29muJ39MCsmXFXH0w0/Z8Y0TKpMTH2BVPBn+UXnEPsykFf/eC72qn9K1OMFstpcz7OvTcVsWo1vDqm5QNqFkgrhAtgF32jkRlxuTPC21BjdSKFQia7W8OFHd3jwwwnL9PzJhkamOgZsPbEU1wKRgvYiIQqM3fG/jOEnHHmZleHaeroQraHasHYwFzAM+cwHqtjFa1588QnbsNQLp1NKT7iCok2xz7HhOJA+QS8Mx9QHeS8p5eIYQww7y+1FAydUjXQd1qg1h5tzGdwvl6afsxZLwxYX04e2cuVQU7o2uVH/QZKkjhKiZYa120XLU70mxG1/fBtbUmoOr0R/D1hFJ9MN3lFNGxf8YJs8rbzZMh9Ew2Jd3Ta/u6Viud
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380ad9c6-f5fb-496f-dabe-08d82e4e1556
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 14:46:57.1736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1tWYUqXp+scmGYypIkjXs0Yc0fbASfkYpj7Os8JbIDNiz/pr/AaqkyyfFFez74Pg5ZWIkFp1ykOzk81wl/kQ8O6wLL9Aw5dojiRLB2lmAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/07/2020 20:17, Josef Bacik wrote:=0A=
> Chris Murphy reported a problem where rpm ostree will bind mount a bunch=
=0A=
> of things for whatever voodoo it's doing.  But when it does this=0A=
> /proc/mounts shows something like=0A=
> =0A=
> /dev/vda4 on /usr type btrfs (ro,relatime,seclabel,space_cache,subvolid=
=3D256,subvol=3D/root/ostree/deploy/fedora/deploy/610b0f9be3141c79f19a65800=
f89746c70183cc7f14f3cfba29d695d49128075.0/usr)=0A=
> =0A=
=0A=
For the sake of documentation, could you add a line showing the /proc/mount=
s=0A=
entry after your patch is applied?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
