Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5E1CB19F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEHOV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 10:21:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41014 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEHOV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 10:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588947719; x=1620483719;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p1fWTJAiWugXljvxzKwFR9lWBFj8dWs2TAJEQe8WWO6B5AkyoIVypPDv
   aB/1DBRxCF5EW4pATxETjwn3zBcrDVB4oYPEIJ4hwzbBTLUETLWAZQ+xs
   LQeCKIQv9qWZhUFDMKFZoqPF2mxzqtArpCSmsDlJppr4LgTUFLIVNIHRk
   eXg6EVE+pncFp3pdc+i7T9pe99jT/bC9nZnEF+rdzv0zC9/DCVhq9A8zF
   hVAyJRXrUkgFlmvl7w5XR1ncxyrh4PQE5IwPRLMEkKavzTeP0cUB+7Vva
   NEn45iz21roCs4FEUMuDXC5ck5zqdeoZif+aAXkJHcEAaJgWJm2IKoY+8
   w==;
IronPort-SDR: f2x4YhNHIzA32MJJV4HcsDHcoR2AgYnIzOQ6U91aCXX2rHdL/8aR/47PMkInARBJP/Xpt9ynYV
 wXnZEKxSSltXKaniFvfgIr9ZfcN5X8vRD+qnmH3K4wrf6mWJ3sWtQDz5D0sV3uzCPCM/BNRN8R
 L0xjHS8qKxPgQ0i79bcyyrNTvL6YhibTASK5DMSr1o7Kdy1pLXY8a6YzNLndnLfQwUnzUfxR86
 Irpl6vP4Y9Z5Fm26mmI/bUjQNmdYd+CAV20cJR8ExKKtrg/LbeO0ji1wf+/P2avtRoahYHd31E
 G+Q=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="137568172"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 22:21:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTgCOEJPsQXdNOR53ciayCB6dmUgF8MtdEdBh72OgXTJ5N954Vl2mTgh+ic70g7putDDhfuKKytECtDRz5kme7QxuFBk55GHif1Fk+PswEqqNZ7ALJ8Yi2U0RHlCOh2N1YbPsCi80H2T8QUtKpORGUfPVMS1hn/+qqRLhS4VEzg/vqoBsHQQGvm8JK8AEGTdPxkg3DBNo4J4fjx36gvTLhzt5tQW1QEUaZqFcmUENeQ2mJ0ceMkgQTRiD2hGRkkhkoYOE/2Ys1ssh26vuVBRq6fR+Mt/oFjy9Dux3G0IZFcpedNR3yMBo+jUvozwV/JlUd7mLT3e4JzCdU043fy72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GOJD+ZWr2VMuU0GbYk37ot1mIoCSl8PMt4ni8A0WIMcIY9RRWft1g9f/mvxa8XRgr0O740+w4coqKL3qLUvpdLMZ0nTiCX9Ip57Nk18/9c947GUnvTannwxUIVZ6KEgKGR81M+2rgPJT/61cxAD1fVFdOQor1vtJ4rmPWCbF/9hXPMQk11ligTfuNGUOorxiYiqueRD9T/lUu4l+EMviLId+gmnjmaGfx07Vgdpdr9sUzLOJz3EJ2IRm0XdRZJT+So9KM+/IHt0SFYNj+QjenB90vk51CkbzQXR/N5C58smjTYdr/MFJ+2mlDh/GTiyY5nUDTDsSpOw+3ao6lyvmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=t7+uF+vbRgDLFRefUfrHjjyHmca/H0xNmrwba2ApvFK7XpqK/E6JRiy3QSYXuEpdaO2W+QVRc8reZoaGRt9R2Us9GpFfkla5YxvicxoSHgMNj/4QXEhMZze1EvqUbyrbq70whWsISacZBrxSyyDDEVnyNhod0gCgSPUJTHNNMpk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 14:21:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 14:21:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 18/19] btrfs: optimize split page write in
 btrfs_set_token_##bits
Thread-Topic: [PATCH 18/19] btrfs: optimize split page write in
 btrfs_set_token_##bits
Thread-Index: AQHWJK0Tia7F2CY4xUWh4O3+01oqcw==
Date:   Fri, 8 May 2020 14:21:56 +0000
Message-ID: <SN4PR0401MB3598A91E719D71442594FCF29BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <a07b15ea5e0b93f2117ffce2236740605c2c61cc.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf0cb0da-e78b-4ed4-94ee-08d7f35b29b9
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB36626D750B20F3B570F40F0C9BA20@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDLrSSPNGsqxs8/DlTP1NAez8Zz3jEcjjCZ5fi5AYwOdBMcqDJl9SLCwhfN5PBQWUUdpYTiO3+8peuCK/V3suyzb7wYFQq8Vpm/rClln2NxXAw8CDbUFqJwq+0UxUXYPcSbHJw2SL4BhDak01YTTGQyJeRRLq+NUlNX1Vw9Nf1nHTs1w/EIB8svib8U7iDNNGaEXgcagCBais9KBIvg7welCne0cCV8GZYx2IbPQE0Kt9V2pbQEuKRk3YMnjD7CJiUPCdc/mW01G8cPwkQGTcMmOQsjWX6nTwhYXz2AwMvQoJFj6tmpr11gkXm6uH8zWb1orjfjgyfoWA1C8ikFToiiHiy5Y8gkEzgpfBGcHMwzmO1MFC2R6Y1Ezt4nmbGx+vU3JLb05fDS8xPcu8N8PBDeq4CYRlF+dI7p8c+eLXfLKUNTYlXiZIKH+KKz96F47/sP/P7kn0hFDqh7WzlbbJT0+e2s/rRZvRoccUyZu2t3l7haRXBmu15SY84EWoq5KjtvAWrHU6vRasNLZ7ehCYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33430700001)(6506007)(19618925003)(91956017)(52536014)(7696005)(5660300002)(71200400001)(55016002)(76116006)(86362001)(66446008)(64756008)(33656002)(9686003)(8676002)(66946007)(2906002)(8936002)(66476007)(66556008)(316002)(558084003)(110136005)(83310400001)(83320400001)(83290400001)(186003)(83280400001)(26005)(478600001)(4270600006)(83300400001)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: S0E/9/Zx4kI1TsCMA2SeeQ1e1aYTVUX7D5D2naEfyYhMsXpJHjTxpNmA32VzXhUJYzTZndra1tUnJrWxL1SW/zmh4WJr17iASGhB/ntAboDmsgQngRSnnDl5Ks6uItjVm1Jit38e8rP13e/h4rzHq5f0jTjmuZ2DTiD44w6q9KV6jVD+QIn+fIe7FGJKyUPP+cv9jyH2gZ4dsMNK6l8rl/hZBgfdmPMugr1qKNWEjUBfPd82VolYj18/9hMepwu9FQiXx3/2PUyF1pp5jRgZv+UHKi9vdZKy73ak5K0x+A4RYlkyj921y2fRVTMc803p7BbWQ5b+nq/hx0x18v1gtMibNmwsAgsRDBDns6221PjnU+rV185lDQcDewmDE0nL47hubHrlETFgBoXyHpwhfo6Iy+1KkMDrWXaTPm2xi9nHkiZ937XLR7aBuLj9pr+dC4x00njevy6qHmqL9cEpRGvlapXB8InJ1l5Ztn7Yzpcp5bJU6ps2/DSbM35eFZh9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0cb0da-e78b-4ed4-94ee-08d7f35b29b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 14:21:56.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs4Ksa4qnqZL1b8p60kmFujmWq2Nu896VCLSPqdV1q2KUUURNssyjeUgoTSNXVsdCLr463GHICaHBaD7t6B7bdINj1FBoWziXBdNaentITA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
