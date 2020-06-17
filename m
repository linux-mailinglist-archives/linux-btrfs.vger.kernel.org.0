Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC41FCDEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQM5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 08:57:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19451 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQM5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 08:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592398635; x=1623934635;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
  b=IYe6OL+i10Bb3ba7URBrCkwe6wAyh2UnHBQHOQ5RwHOCMYbQBLfSofkr
   MvYPheybSlwLkQR2jelCP4wn/jmAOzqHZV/ZruYYMy8nESIFieTgCLgeZ
   eCmvhuCN7Vf+faKREgBq1HqB77tmtZZO8hWulnATIcHFmVorZcMpI7q+I
   CcVc6e7FVm+14o5JVVnVrkOB1+mzShO9kJZwnmwKMPaUE18C+RTTyIM7R
   KlKnRjd/bpXgpMlbovSWfTvp46jNMV1qPFBkQiqJ+FYDDUImiNS5MEJUd
   6dGZQVjsCfC2xA7jHPZ06lXltsoif9lusWN2+AiUYfl8m+u18eUzAm8ke
   A==;
IronPort-SDR: dlWv/NLqfvG9+883nM4+qshwTdIKatM3rq5SDN2Zs6yiScXg+nTbMHhKlwqX0e0JiNU2FoGj/u
 CpJmdi0gWYM8Bfa+h+Vp+AIRHBmxMFraswoOg+R2wldcPtlx4oGrYOmOOhuRbsYw+jbN7OfCVX
 zBjm44KJ/8Nt5tcSpOxA/vAxttKADssrVSUS/5wVP1QlOeilbD6IxEdANdN1RB8PWvqIzzCBrK
 2YSWzZTloUb5eMgJaghMzpZG5rogYVAy18VuprCNCgKbvmkHElmCcEY3gx7PLwWhyqOjU+qc3A
 hXY=
X-IronPort-AV: E=Sophos;i="5.73,522,1583164800"; 
   d="scan'208";a="249397967"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 20:57:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW1uWdQySYYaIhz9ScU6RL+w6d49dVXbzy3xbol2Jod19kE4sZ66j/mfRJAsfdH3mDJgxmvYJUgQ3IcH/MDDybw7EJsH/yJpXB9BwS29Sht3auw3izmumc5j/Xs/d4m5sI96BHFdqbuEtn5vlbG+DezAmEmtPS3K/nbXyHp4muqu/Xu6smSBTxXSif82aMEad6YlwsS83c7RZQgORUnVkJYuhx3klTJ5TtwH4kPOwYHbzI/O5n/it3nhsZUU/nzR1O7apdwckoUuKU9m5xP1WwE9hjnLdNmnRQyU1sjDrzKkEIPT2POPnNDNc11jadVtZ3COkzvL6vRULLE03XkYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
 b=PbO8D33TNU177S8eVIELopzS3NfpEwTR8eJleVAZeQc7fTX8bGHKph5GbFCpEM9YNLwf13Imrr396qEUkXU7zj4FT+G3LN9zSDER+LDO0zJ9ZaR1bQEkMnf1DLINm+ggwTH3upWUsM2krwS9Jk30UWaITI5eobtYV1dMJxPr9pLPo8Ctb14aZOMzaoTkAWpBw4LSNaRYpM96HWr9Y6dP7KO2VlGe+na1iG7x5d/tGtVCDk53H7UPaeFFWwxYVTVLzKFyUDLA4xtCm3fjedDXv5yLBLEwFWHlPyC4aru8/bJEYYyndzW1L6nGqws6knONLsamrknHOfhRWxccHN4ixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icYTXb8frBPUuph2I6Cn1JGGorAmF+UoXM3uO/qEO3s=;
 b=yhzX1q9c9PVoyCnjXHSWuurjBTFz6qiLMbMhZnatY+XifYZ1sGhIXRybJA7Xqo5gHCeYLQhn4BVih/rIohEcQJhOGC1bw3fczS821oK8c+HIz9oKtfjvgHWxYKa7UFxZN6B/CHbiJGMF/J0v/JI+KJ27RAqthc+eoBw/R52T084=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4157.namprd04.prod.outlook.com
 (2603:10b6:805:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 12:57:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 12:57:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: Remove hole check in
 prealloc_file_extent_cluster
Thread-Topic: [PATCH 1/3] btrfs: Remove hole check in
 prealloc_file_extent_cluster
Thread-Index: AQHWRKbScSlJzxbnuky8feYtt6R1lg==
Date:   Wed, 17 Jun 2020 12:57:13 +0000
Message-ID: <SN4PR0401MB3598E8B78C2F65EDC611F1BD9B9A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200617091044.27846-1-nborisov@suse.com>
 <20200617091044.27846-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a1640a7-590f-4668-f376-08d812bdf4dc
x-ms-traffictypediagnostic: SN6PR04MB4157:
x-microsoft-antispam-prvs: <SN6PR04MB415775AB7FB7D634CBF0433C9B9A0@SN6PR04MB4157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqU31KVCyQGejzCulGcde0qvkpuLh7DUdaaGlHq8hX+Rrqd/qD7m/5EYi62yUROOEwf1xH5VOI3xR3R0gUWPhceBWySM7kSyPabWCRsyiM3WwceiSH+BfZIjIkXS5y0RPoOa9TrU95RGi7c8vuXGMk70r2HdAlqXutieeb8Nnp14TfdcU3R/yCuIK0GjYJVYWqS6/+rWil9o0JjrJAWrVIBuPK1rRjm/PM/ekW0tBpENOH1/XpbKEerxJG2MQsKN3oZdY277aUnrYOiWTP0fou0Ykc4ZUB8PHxl18hrCC0Shfd1+kGp+T6YTpzhNSReVvOXsUIf3tIuC7T3ruWgnvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(316002)(66946007)(6506007)(2906002)(66446008)(91956017)(66556008)(64756008)(76116006)(66476007)(4270600006)(186003)(33656002)(26005)(7696005)(55016002)(9686003)(86362001)(478600001)(558084003)(110136005)(5660300002)(8676002)(71200400001)(19618925003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Uuen8/GD64/H07uiLJpwvFxtrfQugB7oi+0AX+1MR1rh6aPpgCYaj+OHVhvO0as1Wo3qIxgu/tF1t8GEk0225eNzBxmpFw01oy0YGior8/p5WvdkLy1rfhSMiAeciKp3vT4KT+fZrEqP65e0oqfdaL/xZ0qTL4cJukpp2cAk/murQmo97bqVUnVhsJz7pAoMAr+T1Q9w4RUd0trnzhYulOgsW5PFgYaRO6sOEba41F0WqCetRMw+mKNrSs5uOlOATmscCr1Jwebhnmqgd05Hhvw27SH0Sqh7eJTcX57abf6Ab/Ts+35E5ZQeYQtIbI6i2d86JmBFF/FgObmSsHSRpFXriZn6iZgAh6Eyx2XJJ3gomqRup3jcsoVexHicSL8d3bNlUzNrGUnMeStXGQhnlUgkfBDl5CrXxhYbwXu6p4aXIa+wIDjwVr77B4vLFxhVmrfteMKpgTyj3ZUo4R8ZOaMS78uspJABQjzFBaaT2qg/wHqf8gyepgprvDLw6hSD
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1640a7-590f-4668-f376-08d812bdf4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 12:57:13.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tBJuabdmVbT7nJYq8kMhCuTW0nWlbdE+rdUZ6Mkr3+5SSfKi90NNEEDnGY+okO4nNSGW/Y7S2tjjHeey5IZ11u9QtWPMlTj55osefsx2aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks ok,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
