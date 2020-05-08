Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88421CB0B9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEHNqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:46:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42845 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHNqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588945575; x=1620481575;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=YrToP/p0Eh8syBh9wAbNFBNfY93Ojznf+VO6E7p1j36O8rCBOxIhkHph
   VE4KXNo4oJt6YisnBz4uLJX5cZINaN1Y7Q0p/jZnSrsBy/jZqifK/gBOT
   9uFjaQw/zIBN77eQdPNkcBk5DSsaK5nnmucKAM6B51JbFH0ivoFDTdTQn
   rekKOi+4S8eIyzhxp7/Fhi8Vd9o46VcNAj6gzAlgFwGDxtR++3AOzRKd+
   5KuVUdyt1dhU9A2Id6KTCA3J8nlUbKFyCzWvWij1nuGo+Jof4ParZB2jv
   0Hp3LtZRdTg+phKNP1cV2nI9sTwWcarA6ecBwG31s4U8NX5UOYG7RJ/Wr
   A==;
IronPort-SDR: rrHNfsJcpQfMRpZqn2I/0Tblv5W+L/bwJO6uGW/u6i7gWCVkBq/+ATj8A2bJffRGpDyJZe4kU1
 eAf1TTGKSnJx0EpjElcj9nVZnn2nkyp3rx+GjIscOcGyLhyH5T7lQXRfEZtRmKPsjtcnq4KH0M
 lIuz6fBAynhGYsaMmUI96m80ZHeqzofegbozF0/j6i2jTWAdYuH9ocbbkyC1jmecukCHVHSbTy
 bAg0rkSPAu30pVLUR7yQVKKRJJuINlVjlD7SkYAhNtEDfLEy71BSp/kP2WtT3L8bsnQ2DLH2oq
 IcI=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138658949"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:46:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/pxg3cgSaRih6P0rLxsjeQr4yUYA6RMENDAfVNfIUofNAa1qLaj+ythLO9r4Uv4h9kh/LgJai4akbRh8axXox/yUXhDxM23/oqTXyva7XZGzJBDdZGHYi9wecM0CMEKtU/yf7R8xLeLxWT1ETE58YnpL7m8JSyyi1ud02gqjuaATVVcRCTcWOcP47OMnPkmcns/K55Of6mrpYI/wssEmJiSAplZPta1KtXhx6z3LzXARmcbmkusB3gOmIVwztfQUjRGyp3inTQ3giKQRHV4EoW1vdMf4T6hwe6eMXfuDEcX7fSajyAnQCSF6+pbD7xyXjyvNCR66HA4okUHotCF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Kd7xTR69+wJ9q73dtHYYoVuVKH57W5PBdENoboyAZlQ1DsDMptNco0NRyEHDi8MG9VugX1GfwQMxAteN4ETRDEtwUtjOWR6V478ydzjw+t9rIowa3HmG0AaV9eci8JfxilfywBw5eUEyRrE0vQNyJO9ftHOYSh8oqWr2W1Nadz1m/06967DnvwUmZhXoNJhya/0Iwgv+hYaq9Ez4b/wyYPCrkU1T4ZMLpqstiR/wUK/eDC84dHcsTstwwt7xqkrbi/82ZfjhzZ37Ci83obvAxUBKoO5EtgNH9G3LXTFtPQpB6A0CPceMQKHWxR0uEWF7ZGv7JxIVV27XreCClNA/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Dli1HlQuFR4kSPRVhuiAMxsPeCqnRMDwoUE6NKlvKq/wkR8gWUse6IyJHqGXXBZYU6HbPz70neiWOCBL49BXVbqYsAjESCAiGa/f7kvKE81R/jNHYjx/bBLGOQP3XimPb4JIRBP6Cttk+6M/zmOTMfWSpo92Cpog1pvoLYvzsO0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3663.namprd04.prod.outlook.com
 (2603:10b6:803:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 13:46:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:46:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/19] btrfs: speed up btrfs_get_token_##bits helpers
Thread-Topic: [PATCH 08/19] btrfs: speed up btrfs_get_token_##bits helpers
Thread-Index: AQHWJK0L9BaXBslwJEOJbze7mOSGEA==
Date:   Fri, 8 May 2020 13:46:05 +0000
Message-ID: <SN4PR0401MB3598C128A5E1FE04BF20CABA9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <430a17cee835574132a49c60883b64fdf39875cc.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b6d57b8-7a12-4378-be4f-08d7f3562788
x-ms-traffictypediagnostic: SN4PR0401MB3663:
x-microsoft-antispam-prvs: <SN4PR0401MB3663BA9CC86850AC3722CC999BA20@SN4PR0401MB3663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESchhKv08DlcnwZsWQes+I2w6MTFCLtHzbb/rVIgglEkwAZla15rm/xeHd1wL4qQmzZ1o/oCtj+VxgL4Mz7eaHavg1FkrZZfLMkUJ+o1Oz/gWerzWYGef05qzrCKg1zlVYKnW4jC+2uHUrWGMKqQE30teIeIO3G41v3+I/h3k6dhHwTPifMf4iuP3QZEOPAdjDJJ6xsTcNBqBoWgJANf8odcnuEE+1Uw7jHrzdFC1VmWiWaIPwhjPuGbmnMOi4JY0VqOvB+z+pZrEEYrV/tr0WjMGTH8UCfonWVm14Om/1onXdpAY3ZccJGx0wC7AA5dSFyU2gea31KGhjrGXlPoSO6BbdYXIxlOqCcBKgVCsHqumgihMY5eABcqEN1tDKv3yMdN1xoNBrL6qb/9ixJCEPrUlbQoxRTkorE0k65f2+bDwo08U5Z3m/PGQd0Zi5PRHJqMlOQB8hgJ6M5Mm3PVQqaXMpKPk7i6AaVmReFMnWNt+DBMSdg8HoMEw51DHagEsEM8xY5g0pmbPQHVqaXfIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(33430700001)(55016002)(19618925003)(33440700001)(110136005)(91956017)(86362001)(83300400001)(186003)(71200400001)(558084003)(9686003)(83290400001)(76116006)(8676002)(66476007)(66946007)(64756008)(66556008)(66446008)(83310400001)(83280400001)(33656002)(316002)(83320400001)(7696005)(6506007)(26005)(4270600006)(478600001)(8936002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RhgdrE5KNRkGvkEZRD8WOPfcUaZqTsN7U1QTQ+40qtxc8Iy8qC4ZcEWW/dkm4Ow4L2LAZsMhgTeEpQKsr8fKxzuq/LWXfxn6GYEsYLfpAZcK92Awiq/4VubSUduHVmnt5tzkB9rJvsC7iglIpF/7ftl4RBnhOzuD3YEx1WUjHWHAZr5QFMlPnV/mUD2gw4rgjpc1pUEDtZIn7ILLI9rHC7URzi7IdHo8mmL2CFb9dKl2auMPRQfDe4mLRM2DfeVVnhgDMJzM0wF18bCmXelGflMIqSi3ilWGNE5cs1OHBoneoUg3Y5jZS+w4ioAIGgaa00CfVVgM3yHPjlS3pxusyzFBTE2QT+xS9XKxqxq0FWK0tK5Ch1JLK7D5QI0ADgXO41k4w9ak1rYWjRgKwT3gr8PyUL1eWOlHQww7w3jbrN9BvRDsIF97o5CmzsNZyR1er4HDUqgg0VaFDVjsnKV+Ccl0+biWPsZEszaLVPVMvedElQMIVMI4bBaCTy6toyEX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d57b8-7a12-4378-be4f-08d7f3562788
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:46:05.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5I5RoZBI403KhdCrLSVjwyGbl1EgjDTumUqxSxF//W6BZWK8WJ8dpp6FecTcQdEdo/hMJAtlMCrqnvbYOcb8Mg4ebpVu+gQB60WjWOa72Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
