Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEAE1F94A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFOKbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 06:31:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24845 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOKbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 06:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592217094; x=1623753094;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SIIr4cT9E09Nu+pwdDfnxk2iMipzxKqMbMKs1FDbaP8+Yb6VR2qko4/q
   jBVevI/3hGoaMYJddbqkbqZq7zy2pE43FRxBXongZznTUopvKlzGwEzSM
   PdH0Auc708b6Hn+wgzPmYBbDxqF3EEq65Cl1hDQLiB2vSoaQHNKYagRjA
   OKxlg4l6GotKLTjewQZQ/mdc8xogityCK1PvKpQUCzgH0TOZtmyyjd549
   PH5HXc3eZBk4Ree/LNIbQJb8wrGtScWFiDSbOq5VRLkxVd738PJyYv4i9
   olByefN7/y8Tmpz5otAkXqZ11LOqejiKNDHN28FDnrZqFisExDg6kyc0C
   A==;
IronPort-SDR: cqBUpQPtmD3Yrff8ABFW/vLzvTGuJUzHc0Zhfgvew2JdIujjSIhjMpipEs4thYLOhNqTLS9qgT
 HYN33lt+DI8gCuEHNOmC/NEo2TEX1QA/oo8NCbIpLKWcmv5h1X8i5dcnDQykQXewXaIJtfmhbY
 PT0p2b/9bz/tYzvbwpHnVW+jjW2eRR1l9UfA6sBwiH8s6cRrEl2iR5YgPM/U75MCVOCnQMm0xa
 yGwWm9tTTu6VJ+EHYlCn4Zem+yzKkol92OZRj2JdifaLZEeZ6j5mwaMxPGWEc5JOXRX8P+4dfO
 Jnk=
X-IronPort-AV: E=Sophos;i="5.73,514,1583164800"; 
   d="scan'208";a="140289042"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2020 18:31:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFg9LOcJLbvpKUtFcWe1YZeKfl19x+oh3OEYTuAze5ErH/eyLEiPpt5pImFS8LB0WoGKyyqc3kfnFMZISPJ1u3lQkoctCCkUVwA3NszTJTi8WAV7vkCEOeFuuEmZmtSLtgVX/WhGfwrWMFHQIV0WcmS15t/NWDBa1OLWKE2GzWW45f+92MQrG08a51AyEAnDKxzVgAcpPIEv+y7yHSB7qKtTE+mcXsSjzG5Rlahtwy7vWjQxw+ga/4E2pGhz4sHsNIbG3k2RMGqGq/INJ2ZVrX1mk6x0rlp3PP5DOMImL7DCVDA2fIAfLp7nCCrcYMfVjOYzPn25InjLb9Q0Q4lfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b4bTbGNXWDSf74MNKhUiY8v9LtaONm1p7O/SVsJVxXRfWwVW7PBmgIOKN01pNe8IqKrx25x4Nu7YDzMmilDCo70Foli/4NLf2fsMgl0Ulade9inOYrfvzWhmQqc8kx1MFFWNG1sMeCWg4nojEModqxXJ5PtaBty29yFSf/ejL+Qw8IFJixepax+KwxGh0Kz0I8IQJ3ir2bSd+D1tuLmYmtEoWyr2o5OvK2SRtfDDlyzOj9RsdqhzdZ3eNQkdLhqPfH6wh/V3PGjpvmtKvHK5tuJeXSY9EbIQ7HZBdXRQQpCAraIhebMMfc5NyZUrw59TSEyQOb3g2wOnY0M610omLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TD99JBt0D+uIoV9BApZpyaWcdAXMao8qGZG0FmSCwhW7MG6dt7rKxODOAbWluDdc1JY0fHfC7fT2hCyLizUKJ9E1YzQ3K2jdQuN4z57EZ1HjKzt2t3HWK8KeOPr1UPmb/ZnOZ54Adf52a0lpBgum+Ti5TXWomHJIiBESR/fl188=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5246.namprd04.prod.outlook.com
 (2603:10b6:805:fe::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Mon, 15 Jun
 2020 10:31:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 10:31:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] Btrfs: remove no longer used trans_list member of
 struct btrfs_ordered_extent
Thread-Topic: [PATCH 2/2] Btrfs: remove no longer used trans_list member of
 struct btrfs_ordered_extent
Thread-Index: AQHWQvq9flfuo50G00K+PnkfSqsF+Q==
Date:   Mon, 15 Jun 2020 10:31:30 +0000
Message-ID: <SN4PR0401MB359836653162DD1B3E8933F69B9C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200615093658.287160-1-fdmanana@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df6c84be-bdf2-4059-ed56-08d8111744c6
x-ms-traffictypediagnostic: SN6PR04MB5246:
x-microsoft-antispam-prvs: <SN6PR04MB524687D20B239E3FA0BF6AA49B9C0@SN6PR04MB5246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbjdsrBdrJoJhYgfwEM1megMw3LWhUFHSHa65ss12ATdL90Heg+xB+OBvHwKgvjwH55bib73AXajTcFmHSqRZFSM/EsJ34HgbO7vnRk9IJ3ZRpPpMIzoxAfUqQDX/4+q2wV3JOcXBLJeFrWhep+TfLcZuPFE5N+C+cuUDdb5etFqa7mxQfcT1HTLHdSFnzsYpzFp/vUZ8JLyl8Ko/9x/PS8h1KAqifZnoHSGu1X2QyDHIBnrIT4n4Gyn6CX29wCDT019OsW6xfNprG5jxkCS6vXXBXsVMbWDKtYNKQ2TZSdJdsU/bH14gVoH7oWJX7oMQFmvvjONiit2O/QZ5qFZ9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(186003)(316002)(33656002)(66476007)(91956017)(6506007)(76116006)(66556008)(110136005)(66446008)(66946007)(64756008)(19618925003)(478600001)(26005)(7696005)(8936002)(52536014)(8676002)(86362001)(2906002)(71200400001)(558084003)(55016002)(4270600006)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RQ65DFnkplhJbTMai6YPGH+32aOCnQ0Xj/eqan//4wfB+0BAhxzZtnN9OiYu9MIYF9OFKM0ErbTqFF80c+2tX7EK0yYVfxUKwBOiEmtydQ69ri+MyNQ2uwu7J/yH7sdCOms5rECsjKbiBzyv5KX5IkX/uhUp5uPGR3C6Mi6EKvJwqVWM05oByY8R6KMiFuwp7Bi0X6ZFvx8rT+mYyXJcXcKEdHe/uJSi6yNNdkgafjtu/NEBXDGr6RmEq9iVCiQAMN6QOc0acbqTfD5wYDC1VzOCggx5dxdfqk6m4pQPQJNgxB+fuE1Z/pODGi4Tp0OhDzZ7etFdxA7h0IlKQNA+St9EYI1cdx0E5+OMrnfKii9os16kOj9Zz6kGl4/s0sREV4lVSZ14uX9D4taQJQ3jbt+7j5XdTmfliAkzn8iZ2EMhsjWQ/HnZIHU+26Ils0nrAuSR/jTtG/9WNH0i74ALIxFeRkaeGOha8XuZLarKnugc4WbE0/II8JBk2EtCc0u+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c84be-bdf2-4059-ed56-08d8111744c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 10:31:30.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8S/mhSPnKeLvmERVVZVc5vI+Q5ZDVd5uPOztGvlzjM8gL24X5XGkYNgVjRlmMieNQ981aB1ZWjEie38RzRL6GYUIiJX6ZEl8krPrkD7tOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5246
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
