Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60DD4024D1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhIGIBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 04:01:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhIGIBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631001637; x=1662537637;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PTkiFOvfezQu0b7U48DZLFeEftG+A6iGOvJEUm6FZlXT4XRv4/7EUT5+
   Eqvsxu5C5OCd9ayKnyDtjroo8um2NMJ/Cy2gZH+bLfA9cHZisk5zWO/+L
   Zj85c1OgiNxdvq0OOvs/BY0BDsgZXW5d/9tFscdZ4dQyrlJEuK9PbSxBs
   iDsvcHnKVjZSBx4Rtw4HQmQYObaIdesJp7jQ+9wxJkmyjFQLvDMnQQZV5
   mzNJwcvgIo8vBus5wIhNaUZ7x7ClMeYndqpKvdBMRouynNwyhCDv1DyiR
   tPTDkl0O3Xg2D/zcGHBnsfnowXDHHXUInM9tpYNKhCQqS2M7G1x/wgG/p
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="283149085"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 16:00:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt0xYEpuH7tCLHQ0E8aZXIX7biQI+mg9Acq1v9nF3g/kh29TomK3QQXidUlFNAP9jtBo1duMfsgf60cBOOoCKmcVcnDSK9fremp4MOvxqF55AZMfzvxEU3KV+wsPmqddixDDs6/PWFnMpQ1Mtuxqiar9jxiThPzv+27uASYXjx6QZ8Qr+yhlC9fDF5q6cPY62/0Q6Hg//OjIQsOGeoJBRSU1DptnDs1iCP9KvsN2rqQRdHhe414BAVyuTaD+5dNmyoJcJ5rFdFzT39qMdxSUB+CiaEMXhuaS4XLOwMB7ZMN2f+Qzj0lM9kG6BsnJwOQ18672RW2JHI0SjneWE8fxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=R4Y4XYWWU44k5kxT3Th3ChSyPfCEFckX4KyIZsic04xE/lTYkCJBaXkIXIR37X+qqKZmQ/U5bbjg+6HaIbICexbX/OeywWA/L551SCETs6dgiCUTk3VyRjsDCYpCIOlGPWuwVyDDDBOF302xCTzMVLnbqQsjYzsGEwpApg2VJb3+AlPA3a1N8jpuBlvoOuEdx8vBBYmjwV/S6H5Hzm1i/0OOsQcDINzvIE4yxUPVNTApzdz96B4vtFFS9l4RQnWzopjr0dzE44AiAnVDOyA5dxjW30gHP26xf5yA3KNjStTUlgrnhdLSbrggMflQOlfoXrf4ycN9uw/im+uoQkfSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZazBL2x73Mozg5v5mrEeS3hvAXtCtAcXD/Z4WJuZ9XkupLYQgUmJ4Sqy89iT/Exx+ao5F9eSpdTMWHhufhNP8Ykg0/1iwibIueq8ECXiH9HfgtP0/twTBmzO34DYmuJALVulOxv35Gw9Gowoqx+9kHiYC9li6rqvptiza+0BwRM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7317.namprd04.prod.outlook.com (2603:10b6:510:1e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 08:00:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 08:00:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: fix double counting of split ordered extent
Thread-Topic: [PATCH] btrfs: zoned: fix double counting of split ordered
 extent
Thread-Index: AQHXozCfDhEoezUJ7ECsHHqeeq/Q+Q==
Date:   Tue, 7 Sep 2021 08:00:34 +0000
Message-ID: <PH0PR04MB74169D3DBE3FCDD7C3627D7B9BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210906150428.2399128-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e1f5dcd-a7bd-411d-1ac2-08d971d5922e
x-ms-traffictypediagnostic: PH0PR04MB7317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB73176D3FA1AAB18E245B3D659BD39@PH0PR04MB7317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFU5bLWIJQ6lmMHdDY3MPX+0mwbVVKH41KfpNPk7EiA9ZQwkbKZ9D58/Q26vuBuR65OgtQqqrJ0jESgQEd4tIGDGF56U7stPe7n0l6iD0Ph/5obkTszRWyd86RItmxKBUuNV2a184EpdFVEGAoGvsrcNXciujXb1/Um4GYHuQJvWztZyuJ/AKQq1vL+qFEZ7A4lnZUbTzDdNshBluZz9T8OJsAlOUjVgElfNfs81vJVFQ72OLpWAGZh2dWNOQFqpMgb4tNx3DqfVZ6LsRzcz4W56SncqJQcUaLtuq4uQ9kI/LdmL7lMFdOCuY078FRTEIhSu9FusU+EEfFmGQS7m2yWV+pCnQNfMKUSPDJ15VJNr+EyuS9wx8RtDWHL1QWJmPAZ5sdQ4JOxm4Zz6LNXc9JIVB7thZmfFECMKOIWjnHlZjKSY9f4XelD8kFJ4MxAfrJK53l4Vy4VxlPOd0u3Kr/v2/eZ7zwAOzrk9aE0kEnvAQCq9DbF3DaVXN1Yyd891QbYPHpqHFcpRdog921lj2F6F8T1bXqAGu4dAT8J/qwPwCLT54P3UfWK6n7DRV6flSOD0Ym+xn2R0XWvfxMP9FiIWKjfj7ZzpZvgr6mg6o1/nT94cXMrHRYGivi8NvKzcEFlIujtEM2m8KXPAivFGK1iDokXKUUm1yJsaR2OKjSWmpBuvAIYfyiZI0TgQRdcR6SUO8rfH4OLxYav7O5IQew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(66556008)(66476007)(64756008)(4270600006)(66446008)(9686003)(5660300002)(558084003)(4326008)(316002)(110136005)(55016002)(86362001)(38070700005)(8936002)(38100700002)(478600001)(6506007)(52536014)(122000001)(2906002)(66946007)(7696005)(186003)(76116006)(33656002)(8676002)(19618925003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wy1jX4fCqt1yxGSlbg02+Ng1yuOPNxLsARW1qeSW17bUzfef74moQcsA2y4z?=
 =?us-ascii?Q?/zyLcwztO6fVaD9dGTqS7jZkSxroZJR/2x9VLXzlo+Z3+eMbsgibMHfJBJP2?=
 =?us-ascii?Q?CGHTpyhV4l5jfALNcAqNtuI5JYUwv7llfLZNi22UO/Voso1oDCjNbh0v8VxA?=
 =?us-ascii?Q?yBMFYDj/wq8G3uOBYsHb/Lt6A7+Jbd926iS9yHOtfv/cjGPnAJZxM/s0cyoG?=
 =?us-ascii?Q?LepDMJGnvFGQXmCBuplCXxBftoBQKsb/AoeK6Wcov6+PZTP2GTkpiucmoxLz?=
 =?us-ascii?Q?fbg2dThMLEMHtDcE7icyv/t5FEWvHoeyEz8D5CgcUgik43NQbBUri4jWiZUy?=
 =?us-ascii?Q?AB1vcUgPXA941r4+NxR0cG4BPvn3WQptb8YPNRMwTzs0uezLpTSGYT3A1eCF?=
 =?us-ascii?Q?JmRb6lVx9UZjTooUOJpb55ps1A2JkNakWW1AcWGbctS6qv5zbXCv//DqeDo2?=
 =?us-ascii?Q?79rgxqZYUS4kUrsp7Glcvfv3zLm82u6kdN5jict7IKlGxZ/2VXfJXTVgDyJf?=
 =?us-ascii?Q?l0IhJULfCYrGcG/nrLC28F7m1gFrmV1qljGEf6PoDO7LZHFqEAe7QdjZr+1z?=
 =?us-ascii?Q?zmM8xFu0ZPu3+oRcZ+azffrHCH+wWpSy3IeUAxSOOr1kfxmacjSTjKAf+GSO?=
 =?us-ascii?Q?d1CQzG4U9N3QI1lSDhB8nMup7fE95jUjj22qMYsS+m95kg/xbcGGUgKs6ee5?=
 =?us-ascii?Q?8a7Q+w5UngnlzG+aq2KfMlPwn/oh6Fq1pCyDcOnGAhNbhm9SNuSXg9tfN55O?=
 =?us-ascii?Q?xYR2FyTfA3KQhX2JjvTNswNa5Yx6FAU6TBqHwHeC2RAG9i40QUf6E+HbDc7q?=
 =?us-ascii?Q?T8ibUrVqULxma0KRDkRBfuNy2L/uzH0xf3ipcQzN4+Q3KwB+Ck+BKmeSiIuo?=
 =?us-ascii?Q?+htefpneOkdzPQjREV35cHVvc44OFjbgFLHYXbYt2232ua9s0fXKfdiDiv07?=
 =?us-ascii?Q?Gup2e0hUp9hiyQuLTiCL7qGWXUE5y6zZnoA24JqGFcw0BfPxypozDNTfs5vb?=
 =?us-ascii?Q?cJf3cEHHD2R4AyMg4sfmfSJGmld8/0WA0k5gpCHoelvEXf0MmgRLs45Ef1ww?=
 =?us-ascii?Q?7dRKmPtxSxA3Yj6gh2dZ8HE4GqDUoV1TXf707oULWN82eYZKHl+c8+81NLGT?=
 =?us-ascii?Q?bKepProoctnprfE6CAMrcBm6mwT0PpMO04WWYNtP+MdB5mDIKZ3KuDTEVO7C?=
 =?us-ascii?Q?ggDLecWu3ysl3Ze3n9JEhtOEpQ2WGwdRqHrF+E39mi9MF5RJojL7yM013lG0?=
 =?us-ascii?Q?LdWNXkZCiho4MVeizheP29TvkxXjoVpAZxpExjxwkUlys3ENyLTw1gFnDwdT?=
 =?us-ascii?Q?f9RS1URCRlvywptLkA6RC9LTy1+QUM5q1T5xBMHPSSIHKecCIb1HsmSlgQUo?=
 =?us-ascii?Q?XqQtwuhCGixqr+ZpJq2fk15BhdbPYpgIrO2ZxQJNg4ikO2Yp7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1f5dcd-a7bd-411d-1ac2-08d971d5922e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 08:00:34.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zKIJTxCI+9PC0DFvEnWiTy9ba74gkpFxH+y3FgZILUYKQkI5981JJITGcGuOIPA6nNMdkM5K0Rq5BSBtOGO7s16nvvbW+CravcdaoKxmbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7317
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
