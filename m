Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB7268A75
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgINL7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 07:59:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgINLom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 07:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600083948; x=1631619948;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9umMniPgCNWpz9AwHU0sybJZj6/H8HLxTTxRfdLZvuU=;
  b=PHuTaoOu8eJq/LDecCRMi56IsLoCAczONWS1tqxtcc2X3Cw1o0wY5Uew
   tX/jBgl/lDad/j0no64Qfn74auxcVPDn4mX3EnWm0YckWR4vjlvUQQ5px
   6Nge6RkyH545Rdnz2r7GQ677O2FWmDjTUkBOc2Ole70MqSFRc4uvSBi13
   Zz5FKuvyYC4Vh2PnGAItKG6x0fdKtpawH186gXPTc5VBH3C9Q4ho8M0YD
   58kSKKfembKi+/nZHgR8CEyuxa3/9YLLemFIXeM+6VCftC9Ti8BRDQztU
   E4K6Dvo4vRMtEzfb2wzritkHV6X+lT1Bu6tNTVtOQ+dtYfm/cmlH4dDbe
   w==;
IronPort-SDR: lxFoK5aRrpIiGJza7ep/mkUuCZ3+nRIx3+XI+CDbjcb1uCSzjhWERQi4vxf5yGDAKb/I6VLjZK
 Rk1CTmRYk3t06X9ET/lrt+vZYQEvPgzuXXpNhd2Il4CoKLRW3vQAA99y7N6gmBuscAhZ7CAH3Q
 qLymc3F63jQNwKhKnawGi8mjXU/7S9p8tKHBcZnm/p2GNJW1O+TJWU/yxAA40puMHZ4Myuyfz1
 iiiwmaq1bbjJZ6HVCNnUClcb/0+bO1y2fPnm+h0fIx0D585Ay1HgP+bmV1LtK6wXvOLJzbB8vs
 MF0=
X-IronPort-AV: E=Sophos;i="5.76,425,1592841600"; 
   d="scan'208";a="250625090"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 19:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpzbIClIXzHg5WeDO4Pl9h/Dm9cM5YfPWjcId8CuALs1V42VND2Es1OqwT5SNUIhaQZhrG8a80qxtD0wS+IazQAdmIgHaFArl3QG53theUhSDcT7nTCpjZ8Wskx1GCvH0dVS6gYxCrhfazG28VNB+QFafwcUMbV0GMlL7jesCAiT2ntvv5eLhrkp40/swlqBz9qILjjLx3vPf6qfcsufrqOjbR29aaFc1p4dx0syRcUXT0fdMAS83Hbs0pG87E3Ni8eNTmpvzCnmcOdIWb+GcxwqxjTHtM8sHiM4MfOUKBYohWYoh8e1UudjlSJ2Bu47rqNOOaVMqwBD4t06wfmE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9umMniPgCNWpz9AwHU0sybJZj6/H8HLxTTxRfdLZvuU=;
 b=RFO5KvenzhsTHH5Ham9BNKyWVu0kDrHYYXeiDakFDyVqmm4D1JCZW37PJ5sZnOTCyLANHFX/itCMo6IEdL2vWMwChnq0dDlwj5Rt8pOZ3smhzxflaAFWOWSbGrWALybX7MlZNN9IKpGq4WvWGNYdWh7xSbBPxsd4kkz39xiWDEQH22q3oEqXHvLcHf4i0U9sRvZCYI4dgSJfKnX42LP4k6P0lsd81SI+J3ztmvDzILzvfOi2tOJG5B656mV0tuMPDe7Gfp4b92Dj45FIU+p2z2587ayAd2MQwfxgIXXA0ggReD1DgTtNcgishEIUcduyWjD8jNS0qd8mJsSA/uUO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9umMniPgCNWpz9AwHU0sybJZj6/H8HLxTTxRfdLZvuU=;
 b=oFd0xqh6V8LNlTVNZR/ulEUcoFg1KGllFHjbgsKWtM3nNNJKy4rlOs/TX3WtvosuawRgZPOoQYDHES1NrClNyE1AnfnluYd6QTOJeUjG1nkDsBI/RK1Fsf+eq2efeAFdlUENGdmUbSDXISm7qL+pgWK79kRnCFd28RnVMmohLY4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 11:44:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 11:44:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Cleanup metadata page reading path
Thread-Topic: [PATCH v2 0/9] Cleanup metadata page reading path
Thread-Index: AQHWinqlp80Hm55VfUykQRnZ4YeYmQ==
Date:   Mon, 14 Sep 2020 11:44:00 +0000
Message-ID: <SN4PR0401MB3598AE6D7F4E67AE980C5F539B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914093711.13523-1-nborisov@suse.com>
 <SN4PR0401MB3598C03BCB90A41366EE4E4E9B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <15fdb3d7-b7e4-bb00-c410-11e871cd9820@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85b4b8b1-dd73-4391-1544-08d858a378d0
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB3520F694A7F939FF679B80439B230@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2B3yqhU5EHla8pqF8DEE9nD5zu19j7oAEMgV1nUiWc7Ddx67/tgvAQMxKgvMzKSuJ+EQ1AVgnmLRanp4Yq/mKrXXkAAU75bnqoNVJSrNRKUiTcmYRIAPMVVOKvYm9LCl4JB29mtIIN98cOYSJqSxdb8fOIwOQjLsHc2rVVYQA+6JCb2L+2cCJ8acNSliT0TYo2/hIi5l/DdC92NhbtUy/q3fHqYJyLC42N5VMnc7t6IZsv0Cb2BLiMiTk0HWBA+7da/Nj0v/J4s4X9eFN24qqL0VG7nur1gdm1IsF2n7D9q+bL7TbWp4UGn2T/pDCVsBpQrNaJDrS7ZwtIftYNW0WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(7696005)(53546011)(6506007)(186003)(508600001)(9686003)(55016002)(52536014)(5660300002)(8676002)(66946007)(66476007)(33656002)(66556008)(64756008)(86362001)(66446008)(76116006)(316002)(91956017)(71200400001)(110136005)(558084003)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vhohPFEz7i2YPwIcrUkc1FZLcMPAR2BFFgy0m6v4PGuzvtUqUD3PFayikBYoZVTTlwm7sZMR4F/JT1K0hF97hw9sBn476Kh5rozA/fSQGz2dBDgKtndg2Y+3BvaAYZHVg76TOhFb7hjdQUpISZljOzrQKwKEUoOGI9URC7Y9T/CqC3oVx1XkqtpU9YPcydE1/QoeVCd1BduAj1EuMdqKBaEZI7FtUbh4qq3C12hZ7KPDH4U+ZOLvwTcoAx9h9fhidNvABUKLeQorRIXEFLEvHS8cvsD8a1mEpq6e0AXPbSNoQg5k8Z2rmy0NxCpe4UHSR4VBYHXMwvY82vEeYxch3jjtPPbi+fnAwFOLTs40t1u05g/o2dTdhiTMIUTim1/KZgmz+D6kjhnVWfZEgM1WudkUw36QDfztyQty8u89oNU5LPK8vCX4R707fSPyl9RBu9aZW3dElgdPAFlUMQ/RwrQQ9KK0xmp27zvK3/WqYbLU5P0G4VLw1S2tMgfSsJMqzi25Pag43hD4fb5+TK96If4uJzRfEbD+ayMC/XfzUumJLDyT3YU/5fG4k5dblsOGicDTD1FY+0IQBQCYg9Gm9uEbkftRHsrBJ/su03vaYbXdgU9ZclPdY5B9AQmcll4QiOjkQXR4mS0dmW6p/WfKwp7V3D4kP+E6CZyXWiQg53dD8Q8oBu9VN2dccCe/LaM+XkoeyoLVin8hbkDOAdvJSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4b8b1-dd73-4391-1544-08d858a378d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 11:44:00.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oyeRe3vr0/6LfwUjCo33qk/oAI1pX3F3LZ0y3FiOXpYdCOJHTN799/4IrpTiapUlwoaEmQc+QJKGny8tgXDQ9/8QFkSrImru2W133RjMLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2020 13:40, Nikolay Borisov wrote:=0A=
> I believe your feedback has been addressed by the follow on patch I just=
=0A=
> sent.=0A=
> =0A=
Yep looks good, thanks :)=0A=
