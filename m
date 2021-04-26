Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4043D36AF1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDZHxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:53:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58277 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbhDZHwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619423492; x=1650959492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=c+b9ga8fwaTyIn3uJyv9On82uQvTTjcNd7dblyAorAZfYFXdd0FAYLIR
   lqhZRo965pFhXhKJt0J1fdB5GY+foqe259/hCvItE22CNUsZeL0bQ8Ogi
   clcOBA4Weqa2LgjZlyx+ilhBo4oHvj64vcPFsYf9xtJxfoajDzPc2bRQy
   4BTLfT6ZLHFln7PgZxWG2mTWvUqaiuSVNqTT9/qDiBW12A5izuFSXNSsw
   c1wPru3bntAdcVUUGb6rGmcr+TFBAFuE6juFkmSywcblYZk+oLo1Aga9w
   QKoZGoesApwaFLnkGASdKO+4p57u28sOwQttsNtED4VTWsasBNTLw8VfU
   Q==;
IronPort-SDR: hcYK1ngpl+rMlUDB0QiHrvPO1fF+T4yeOaMPcPmlDGLMcUvdx6zWi1oc269IV9Ld821soN1A3m
 CCzV0nb+yxFYVBP6LplUcqeJ4VNxtBrHQo4cNHWAeG1n73t18gr3Ve2SReC2m3Z0915xFk4xN1
 O+O8EH5OMeLO10Fb6bJ0awP0Pwv7v1U2BLNRpD2nbfqlEns3/RC790HoX19BL+UJDi5JVGX7Q/
 w8KxPQUJK/diz/Gqjce9Q0Mlb10LfJ2MfoWehEqIf2TSSjtA0z/jKrdH2n7R+pmG2iVFQfCM9w
 irI=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="166799395"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:51:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce0P+AFSj8OiVZBXBk4OcljPue3dYjE1psjhmTvdhY8VvL3Uy33JU5A0Fhtx/QtBKkPWB70mvDm+4lXhWr4B+8CKTSGue7Xs9m8xdvNGIOCuJvN8aHoa/fffvR6EzesuKBMKmjRy/nfULg17QwiA//biRloWq8v+vrYPExfmvPIxeF9XOSKNcAfS2YSiXbYvzinwwuRStxhRtdhWXP8sdQoHGNYVnSwayKDDFVqbCy/U6/itor0VKF6mIj6VC+HRTxE1quUQTRvDdRxdKZ151A9wzYPX4TeEVC9TpMMQxMqHs0W+AKPKI6tz2mwyAAOQxy99I5GHMnYTAoyfnM6pXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ckvzSQOq+e2vzxOlWirWMcSy8SjMtBBgKmaRjwZPVok0yEnaOmVpJpdbZIVlD2WZoYgCfwo9nLoSD0fT3WjH5+qgNh6K3nVviRyHUCF19JP6NxaeOcD2bv2B7yOs0XNms4wNeVggYUg16DMCbRBxTQ/Z/w5/xilUBtAdInARHukC+/GotwjFJWKli+v4UbxfB9iJut6Z5yNLaLbBkSFdKXkE4caSFpj4KWTX+Yl98B49ZiqxZoij0hSN02NAUiXtKcXxrSH1B6HrkjJjxtt0U6QgOhShPzUYCQsIXmrkdWY4d//sbanNybycygJfEW44/7U+DwUjqBbtLTwN2WnbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=li2WmYOEX55N/w0mIlE3SWRE+SXiHvTg6vpXuqcoK9yiuhqctKWgSo6sWljvdAznYpxqf924n42aUmmR8WW//gXAFPo3HbJGoWGwuXMSH53tCwxK4AVfS3VEwwF+vL0tRPDI9guvdj5HUQvGKtEze6Vlgub8T2bAfw2FiYYPiU8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7670.namprd04.prod.outlook.com (2603:10b6:510:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 07:51:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:51:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 07/26] btrfs-progs: zoned: introduce max_zone_append_size
Thread-Topic: [PATCH 07/26] btrfs-progs: zoned: introduce max_zone_append_size
Thread-Index: AQHXOmVqGSDHBXcDb0y3vd18n0SF/g==
Date:   Mon, 26 Apr 2021 07:51:29 +0000
Message-ID: <PH0PR04MB74160A4AD6CE2C68B96322549B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <1023703371dbf8239f11f7fe8061b26dde480511.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a47ce104-ee1f-44d1-0ae1-08d9088819e1
x-ms-traffictypediagnostic: PH0PR04MB7670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76707140C7A84082A1C26B289B429@PH0PR04MB7670.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adjBTwL+ao4lUoJ90YV4eBD803nn9rdK6MwXDivfgHLc0DMF6lRrAccmUrs1oYccZETy/5Z3i+jrv84m3e6q5gyorDwhI0/FrOS0CObAVRYVUPZ+NKEm/lYYtBAn4IzRa1g7qsBQ/r8kxxgx/XWxLCO73eyefVVs4zFlVY5JtlHh9mACQDzxMpzDLDe/4VKgvsek5PHV9zVdMNp6V3atKY25N9O5AVPH0+PVGgoOvzRlDYGhk4JWuysfA+S8ImoQLR0Lm36XKWpMgWHQ6Pq8oiBRIXmn67R3rNzDCNjE7hWX5RiDs8AqKvSq0PcJ8iUZMe7xIYdhOdLV/q7c95Xpw2emQQdox5D/z2tGLRi5w+nro8dBXrmUpODtQ2DDIg0cUBibXlRJhmUSSWfdz1KVnUE/F3o8OeH/M0tUH96gYSSDby0LwJhE1GEuIq6gi3dnONGzFIMl9PcLhqY5PAyw8BfMJjhCMHulMa3zJHNAXm5L5KAtAE2ij6as0XLUSnd7sli6NFYvUyhnEsj2Sd6OV1ci6TnrWdY8ke5c97vE0/QbHSVxoSvnFMX/xHE5uLKX2EmtEBCprZV+R7z2+hNBU90wIUczireH3pFya8N5l6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(316002)(76116006)(7696005)(52536014)(38100700002)(86362001)(6506007)(54906003)(2906002)(110136005)(71200400001)(5660300002)(478600001)(33656002)(122000001)(9686003)(4270600006)(66946007)(8676002)(66446008)(4326008)(66556008)(64756008)(66476007)(8936002)(19618925003)(26005)(558084003)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YEeRqOEL8REIPdmkf9oDarAl5hBytq5ns3SLdwo2hgCKsyOiECBRME9LwWE9?=
 =?us-ascii?Q?my63SJI5MQS7+kHNvycymSwqAA5z2SL0AvLkNZnsjExAxEaLJWyu+etogrMc?=
 =?us-ascii?Q?WYjyhaZgcEIhB5JXLKMkIiaFZC+Sc2RWBl3AoGsfpheggUJv+Dl8kVGwliH+?=
 =?us-ascii?Q?v33nGao1cWDshJGZWdthJ+rKyaKzAXUAW93JwEvQQrNtweajvzEBqWWxmi1s?=
 =?us-ascii?Q?g6IqoVhDIrfjBatLkqmRdCmkpoQ7/+KuIfr4YaeuMAO/z4y9mdVrt3wHB5ys?=
 =?us-ascii?Q?rCIqq/345B0hVGuzTFdqy3gcl5CJxPyXN3Q/hOf649KcaD7w/fbGXfHm7o6K?=
 =?us-ascii?Q?If8bd75wU/4Slw4H3qWSvIFcAaS0viqwguJIfEHcbVc691QhVUCL+QQ4A1iD?=
 =?us-ascii?Q?HciHw7Ju1qaTs7jHNIqQDe1F20n0g9didXScFcOq1GDagcsk5603yTRfoint?=
 =?us-ascii?Q?s4F6fRYPWEeMsye0cfHRi759KuMk5VKgb6zh9zSSIcUc+MNwfn/+7GWYZcKD?=
 =?us-ascii?Q?lHqHXldT9/QZlmBgEhYmWh5xJUaBj/K7JbjvN4ExZxf8orySMSrBvrfRCRcx?=
 =?us-ascii?Q?ySLg9CuEIWrM2ubFkDbTP7hEbKqviMToWLrAQ5b13Yhcr18hLGTe0UA0UOq7?=
 =?us-ascii?Q?5S9BBj13X2gzl840U7VKt4FO9gfeu+jd2qem2uAt8bRYfFo542KX7yRp0rJY?=
 =?us-ascii?Q?uQZ0RF/gnqBBp04BsDeVTcF0CooK4zp5a5gjBgNVfpqM2mc1qf+/L1NkfRpt?=
 =?us-ascii?Q?YG39Rhopq6wSPlsxvKLYIRlyPivZH67RW3PFHlWSlNaEswxlTH41rmgELW3M?=
 =?us-ascii?Q?mY+h/VlR+rcYI3SljsdbDMX5ll25vTRese7mbI073lD1u7bwGHmHFT/5Q29t?=
 =?us-ascii?Q?qdtRRT5zvmr4cTbLyolRIqJtztSaLSyJ7pKFguhKjx01mH89VpEOM/HOujrr?=
 =?us-ascii?Q?ifntOcnuwODowMzfTf/vZYgu/fIFSGCd/D+cm4d8kW6bEtazNKH/WhfWZuC+?=
 =?us-ascii?Q?i0oQE74cSTNAWDlLvs9QFhydLVCBjOqPRAS1eRin7EdJ9jAwqQsDwcO56G9/?=
 =?us-ascii?Q?MV0US8CmUo4RBbwwxJqZ/3hJu5xz5qB2Ai3NKj37cfM5KcBlCNUMBGKh8+7R?=
 =?us-ascii?Q?X2XHRr7hVm7rEi7ddTUCsvJp7+olnd6eNqcUk9WpkvBXirORQw53QJKDix1O?=
 =?us-ascii?Q?uKWo8XRvlVDjI3bcsphml7YJR5eQ/L0edtUOoa3DYhoAzT9pGwHYL93lrSBW?=
 =?us-ascii?Q?aLEtYt8FsAAK6yE15mfmwO2147MsM908/zzy3Pn9yyhgf4ljgL6wioxGfcO2?=
 =?us-ascii?Q?mnfUzTZO4jdH9NblrdYHc8okNI7Yk4j+vW0U4ytHJm0mpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ce104-ee1f-44d1-0ae1-08d9088819e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:51:29.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b5DdpK4+obz98IuaZPAU0/1pkRMFZZ/Cy/bm+6tHjAAABKjElPNp2JHKEhh5bmI3lE2xmu2YTAlPRun0xlDRs4ezZoEuDPwL9QBGSOudVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7670
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
