Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE65269515
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINSkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 14:40:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40737 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINSks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 14:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600108847; x=1631644847;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=exMPkT8uCmSdocoy4gEFcVCzbesYmTbbTXW3ZvD3aQ29TkR4/lUcvT0R
   7ADTHBPkyoDm18ENul8tzhDk3tY40ezvDpj51WmEiGxKROAn/Fyil+tHb
   YmVx2vru1sy0Gpk86ZMP6vI6bpi+dNDa3PsivhGqHKQv2434XnFSLZr0x
   ztADJYATqDhGaTyMxXNcqFfBG/itWqRhwHQlA7VJVELzreoI09hRU+wLJ
   HCZgkrWY8c53zXTWW0F+RwnymAp9CwCSKfdpDBQ1LEWJXrVvMKhZrIJle
   dP84/P2jhVA1RWmSEeBncVGekhLFd3xCYAJZA80wsKsE7hrSEN4ptTlSN
   Q==;
IronPort-SDR: MbEFxg4taJjlBfU3F4aaKB9xw8AOSGW95ZaaRq2knrNOkuYN+PLBbG1VUhGtfcDuEqnm0c50uY
 SnBbECmaP5OpeUwTk9TQaq6MD47dSu5XP3nQ9ioG8b+hRyLA7RR2GXEnQ8AvyXPSL+lst3sTnx
 dpJYd92s54YE0eI7fpqAgHr539G14zs4V0DKEuH5eh8RZ5WdKNdJVpAMFbTOV/gn4Vwiy4xIwy
 3AV4mqv47i/lo5x5gsnFvffor62VeCH8RMUgVdEWHw6Ozjw5zP66v0hgljjtI/v+55ZPcd2gho
 UMc=
X-IronPort-AV: E=Sophos;i="5.76,427,1592841600"; 
   d="scan'208";a="256964749"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 02:40:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMq3+NM2stGQvb9uM/Syf/BrQCNTS4fuxepX7r7wZCJD1NoavOOUncyIrj0SCLxGQAHedlh+csibUnNAVcVXdX2dhi8oVYtHhcXy+uayhughL4wwqBQ4Y0O3n1MNHncaUAQQSLk+MYdKwvhHHS/g/gaPeClQIZpV5UHdlWsxFKjKcVLm5HZp6BC5+qtwhrn5yvDZMR+Roek1nNcqx5umYfCWwt613UhEoJRzlL6I7gWo2ttakWeTPe9hTmyFDpKDRRd4cNEhaCMFPPz0wM8jPuFOQo06rKSd3ArihSWEmXK8EOnew518Ezy2YvX8ybjQGM+S/8Hlj+ESBSnYdx6jkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=E52nEH6G2b+K2WbXNungbTLqpNIpSmCGIgMG9xFk/vUWlPKLZMZGpU3rRzhTihh84Gz93VShLdWI90CkpUkH10Y3ToZNCitVsmNA5ZPD2Fx8Da4WVMlU0CCM5Erxf5AovKdnQw3KA3HdVIaCmoWqZVbL7geEy1SJ0+Xo01CiwVSEqIzu3eiHm81phDGq5AxkMgO7BHeZry4ofkQulbPipdB9MVi6z7ZC3SsND4lDlBGSD6WYDUuTDSocAt28hzQMQXXZWMu8mLzYXPqmAtulduzBaSdVXvtyglSrAy6GkO/K8QGwWIZOWbdY81JO4FJIsF8+bdtTcZ5H0Ah8IKvI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TauQVURZcXHCj2Jgec8S1T9Gwk9FryHBIWoP9pH+49UiH7YKX+aePsFKZOqK141XklPk1XotSaaX/IG0FaafeFjLUBXqQe7xbQnfMkz5uBipmKhr64anLrZzn4tq295WRbhgU/Qr18eedpdIq4dpVtiB1vHv9ww195m7Q1y40CQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4048.namprd04.prod.outlook.com
 (2603:10b6:805:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 18:40:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 18:40:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reschedule if necessary when logging directory
 items
Thread-Topic: [PATCH] btrfs: reschedule if necessary when logging directory
 items
Thread-Index: AQHWiqN9HCVgowL6a0uIJZKAA7kaVQ==
Date:   Mon, 14 Sep 2020 18:40:43 +0000
Message-ID: <SN4PR0401MB359812FE635715927F0AC0479B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <606910fad0a0c62d162acf92953d8f38c8537643.1600093362.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b858d4c-30c4-47f8-645a-08d858ddb030
x-ms-traffictypediagnostic: SN6PR04MB4048:
x-microsoft-antispam-prvs: <SN6PR04MB404835E8A541DF8FEAFDE40E9B230@SN6PR04MB4048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVXk0CK0QyxoDwpFcN+Cyoaesb8DNk+zYYQ5z//3Jz6Y1bIBlrDbXtCnwJ5HP1BXVK9naRlUH3yc0ncz9m/Bsz7YFyZGvumBcpQ7GUs159/iWA9B81yJL3fT2xXTYHW8l4yGIOoUVImlXfRHEDytHL8vyNVc46ClKWl/b6DECVRS25tafURVNEDeL/L68NbsS1Tu7n5VkZ9ycBNv6D4HN+Rt04Voh8kpElPiBgOuml8bBM4nQ810ZloakwIBqpKTFlm1GPszxY9HWNjpjdEMhkmxbPeYfbmpS5pCSFHsvEDdUiRregGoqRIeF7YqNb+4YOFHq5BSiELrzQM9B2aWwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(6506007)(19618925003)(86362001)(7696005)(9686003)(316002)(4270600006)(5660300002)(55016002)(508600001)(8936002)(71200400001)(558084003)(76116006)(91956017)(66476007)(8676002)(110136005)(2906002)(33656002)(52536014)(66946007)(66556008)(64756008)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /VEkZg+zZJf6cfq6532k1lkaVHWVjh7JhocDStXJf56DX6BvLAdNNt523G0nplO1h73AhiA1gaxoky4LPyCXK8S4JS0zVHtMr4ToUJsOchAT/A9W3lTiZSxbIgNIh5VtSHhCikPnznprg6qZdI8rPRM8EP/zciWKucCjAst+FpxHzX8SAP12iGK21gEkPGDj5ENSxCQ6v5t0XdrRwKXQhWhx8/NYnC2RM+NjgqCXMdiHlTT2it6mQd1XzT2O2cAuYZRIj70a4YbxmZ/2ZVlfVS/l+UxQnDMAy/hio/5+1QCu0tNR2EagjeJIMjgsI4rmfABLNO0d1WRo8HeqbLQFxwt8s/Q8sIUJlKGtbkLnslX13hHFYI9d6xqpZSPneUR+dQvUf1hchvJNKFNiBWkYHcuaDnQ0cAZBQVFHzD8ffDkR6dHRAcIVJECWydY+BKZqyOMmcSCVRk3ylbqsvNJdz5kENu2RfFsi0dOhUjYJ7Ew2toTHdVrR5IMqppdfbVWmhqdPn+q5vpjbipzx2Us+zwfI99+/FivpJiZnkYJQx2GBkudiVOkA5ycSV6P5z5kqYCht6zNOgXenuvbPOmtHyh8WTBOo2AjQpk+wUPVhFXut4hoqWvywfnj4BQ0VoKZiq3Zl4/9Z9oHadwJKL8dOtdkSw/rOJBPaZjOFOegOD8KoQdy6kd2Pohxh6g0q98ECPekZoo7JJcWgPHhVCfOwUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b858d4c-30c4-47f8-645a-08d858ddb030
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 18:40:43.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pr3/xICKLYCDYXb/3hsJtmoetl2qvt4ZAViLr0ctxsy3kVKn1XpkTV9etDD9YQzfYSPl92+mPa5ll6MMBpg1d74LrAvFmH17YyfDF2tTbqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
