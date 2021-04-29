Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE87C36E821
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhD2Jp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:45:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31762 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2JpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619689478; x=1651225478;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VgYadSol6fQVriBHkmqk0NFhr/n0il8p5nKYh4HwfOg=;
  b=Lz6gD9rFIRz4PAh4kFzrnR8wwNfwGXHIMSHPsBOmFnojOd/2uw94HOro
   sTefqpvdF6xsxahqtcrRukVpooiDmXdrJS+8Y/K9jAHt3Iim86R9PtD8u
   aG8EFwaGjS+s8lXcFFIhlGBd8ssz/wp0Jk4R9c46TXlOq0gMgoApDaRtZ
   l9H1AIGOd7D55KRrMrTn6OupiEdBO3uGXR+9u0DQSZR9Xnh6zoDDt0OGA
   e9/0pFSwJIbB7XZ+z4xWmPCzEXt8h6ZYdcuuoCyeHeiet+QZjif+dWGQO
   MsQtzyCx5SjvdhJfLH72OuzXT29TBNhsmEL6djPYyc1+3ZNTMKCGqW7s+
   A==;
IronPort-SDR: 0MobDsRgjgvnQ5BjLE0TGpgJH/KjlI+l4HIS28PD+dp2gRp+dQvjL2HjuL0wb2kAWa7xhcqEe5
 7X0GC659Gb57mrPLMGbEwahY0JOE5LiH8inUIqR6O5BNNxcX/pLXKFnSGz/1nYfMQhA6fEN/Z8
 FgfWZYPTvQP/PS5g14x0YDSteDpdsmSkDiTJXH4jeVW8KDWuuoCraTkxe8RLQAp9WLdJRMR4gx
 QsFYOlmAK6kPhagcElAWWpK0o2KHKapjagb83X7YTkFPbGNzwaLRfVcHVtFQ+a2/kMhsZ0b6i9
 3fM=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; 
   d="scan'208";a="171186442"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 17:44:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daYPk04uQTeUrUV2l0h8loBBgQla9Po6I7U5kWhhjxFJUOw0JhBSI81XVLmFtC0IbsVKeP8CDFrlK0DVUGGln4Q4I3heXElLx01PwLm0TmOUuTtfiESwAdeHkkP6EHYrvubMROX6gBN3+Sf0Qla1kivOIYEIIkXnXnBtolWF0tlikMa8A20lHZwrdqtUZLg2sFAMzBRcnGXPBYCaLTjEgFq+qqh7H1tJqT+uyfUULqc/F4H3hecYwtdF/6IbcPzppGb96YCkSrvBcEPtL4R7BXajJA2nU8vrj5NaVxS+QpEmfjODILZP0LnH1R0FJKyiMxEILz8STVQWfLj/RVdHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2+WGUUFeoxyYjf8tEJJtFMTFfDZIQZuVOK6sUWr5aw=;
 b=Aqi1b5DJgg18/SnfgVv/aUoMhClZjeRefGcb4vk4+jjqRrO3haAmnpb3DPWHYha26WluDzSmXa6XUekAjvpjgZiXesWlEcOvZh4Ku+4NB+Xh1GpI1wqMnuT93xHhP6kU/AAT5XxCtUvK2Yg50ZIqiGYcv4/Ki02Liqb1eRRwiAfbRSlh42mIz/OeShrsWmiCbHMvSJh4bYS/wCrcVt4RVCcuq0edHRlUpfS5qlO0rlc0w9KekjG9bSjXSPYX2a6LFCIH/XqaRpwqB368qXkws/bOUYyx87JvR10ljeo9hneeLU9tdtpGP2yAV8Sg0pakpP/qeYpVn5L8N/GSFJHiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2+WGUUFeoxyYjf8tEJJtFMTFfDZIQZuVOK6sUWr5aw=;
 b=PuWqtWVvSJPHcA3cWsJ0bQim3OSD6pcGzRkpgF5LyXf6PgLA9YF/ghUeNC//Cup/KexQk/eubrTnJEPKQoZZ7J5hVOOZbHr7o897lha8Z9LVz3N7X7uuLx3x5wFspJoQJCNAgblh68tbJ76g3vhMsMr52D8uDjU5QBnc4SGC/Ik=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7304.namprd04.prod.outlook.com (2603:10b6:510:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 09:44:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 09:44:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
Thread-Topic: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
Thread-Index: AQHXPAr5+g9ID+tNhUSGHsEH/npFvg==
Date:   Thu, 29 Apr 2021 09:44:37 +0000
Message-ID: <PH0PR04MB74165CF0E16A53B38FF4AEEF9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
 <20210428084608.21213-3-johannes.thumshirn@wdc.com>
 <CAL3q7H4z=eePUYbOgOVZhMCp+u8m8bbvKfU5nNqq3rd_8YNm1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4111096c-9ea0-49d1-e080-08d90af3678d
x-ms-traffictypediagnostic: PH0PR04MB7304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7304DAF7CB0B108F95FBE2EC9B5F9@PH0PR04MB7304.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fimI0avUqcrpqwrU9QAH6Uhobpr9F+423lVf52tpEBAs2cBpMR98blsMHdSeL1wOWc8pGEgP5isL1Ud3UULJH7cae1M5NAoaV1eZdIshv1Mc6o4UNz0sjFSHlwAzJ9N0Q3n49XlSAxNsYL0/xWHKX3whW26pfUw/hzkahdeg/ISJmhBtfg630GD7+YCdxQ7SoB2Ke5qFzEChG0ensWZioSK3yAtltvEDjegOuq+ClpTRUxM+Nm1UfO+smSHG/Njwu+GXWoEka3Kr6VFgzanyu9wWg7OdJT+jBeHJ97xh99lcWX3mAH4b8AA/2CxmEV7Z8SOjxTZEiSKIUUW9AJMh7NSsk6gFJ7pty5B5OpRhSUNlyKHAzkiGOuIULdOV3xMIOewxg7GdW4yL6HRXU/y8YxOvLip4niU3Gcmjr9DFiCO1VaB9g0VWGFxsUiWOoDrRLMjOaKR6//Qn7xkeKnda7cWnouWF7rrDepCd61neXc0L3/WHaoka71unQAotJfi8jXCoNjrGFUpbC2aH9+6+hFur/uH1+YFenZ+2PzrhqZgpux54uFzTWq8GA0ZjezvGV/pQbVJ7CGDgm+VJDnQWDy7GYpD5yB4oGEVZAwO4VvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(316002)(52536014)(4326008)(186003)(7696005)(38100700002)(64756008)(66476007)(66556008)(54906003)(33656002)(122000001)(55016002)(5660300002)(478600001)(8936002)(76116006)(71200400001)(53546011)(6506007)(66946007)(66446008)(9686003)(6916009)(8676002)(558084003)(26005)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kABiY+R6CP/9YNXH7KjCRMCwszxbrjqkBldl13pR/SM9taFPOkSamRZcRJj7?=
 =?us-ascii?Q?+mO0iIJyhUsIW9MtT4pzbW4+bnq5PuKyapaUb/MS8EfxRECv276Tob2JBDtj?=
 =?us-ascii?Q?ns5ZPZ5hVd36mFIWQaR4DB7PnpQDJuOumGyZVReSEyd4ZRCnkYxwXibnNp5p?=
 =?us-ascii?Q?aTxBCvJggzfX0PRIGXMODIG66mo7pLq45MiCrucOUK15nvRVOYIEy3STaiSz?=
 =?us-ascii?Q?pTzFfOn6Nl584ebn5FTeMchWFaSfdcB+0gyP0Ic2FNIwXDmJPKWg8lXu0Wwo?=
 =?us-ascii?Q?J6NPCAmrmQwb2DsSjlXzx5ZqzYwbBkTGNdfAfURnhPupjTkqH1V0OG365n5U?=
 =?us-ascii?Q?U+L0FRbQg0zBbqDMQWKc/Nj+aQM+oHTFMbms/4oKzT08f8AYw3MW2qPV4W8V?=
 =?us-ascii?Q?PkMgFtBk/4Ik9kAdMaZEdkcqCgVZtWuzYkpbaGFlJIRTrBUYWm3h2qH0Ni+l?=
 =?us-ascii?Q?IdvgbREAESlNcf+3Rzu5nDGwilV2mEcgT/lNliGKS1J6/4kVuQZNJ0RFy7mY?=
 =?us-ascii?Q?VQKpjqnvO+/7kdWx/3apvYLMxMUjYZvPE2Q7hzMW0qEyHwFVCIKQSD8vwopz?=
 =?us-ascii?Q?i4hAEOzmc8V5FDRdt4ygjysUYMEfxAKr+AUFUGBEzSZFf0lAeMHf6l+IxGlp?=
 =?us-ascii?Q?vKiJsqlGkxfNYY00H5RAF8S+MpkjpsEnJEYbQYcZ8FF23OTYBDzLOmVv9d2W?=
 =?us-ascii?Q?P9O1/Kl3JmWhMljdajOZZ8s3FcZjQOxhVUOlLRs//GRHrtLOc+djrc52cLGR?=
 =?us-ascii?Q?k6peeeIUv+RdUvv4X8E1Z38GV9eidBKA445fzRCoKnzNx50Y8YiU6pGSNA+r?=
 =?us-ascii?Q?lcnYeG7TgXfwwI1RfrXE0mCvC8ff0PKBOtqvAv9NO07y8BGgx0kJvfsjV8Cu?=
 =?us-ascii?Q?IfdGXdei2Gaj8lLN5dFInVtiEINyhOdAi04OQU3esEj9bjLBUjUdIkyLKR09?=
 =?us-ascii?Q?mbWJpYBEmKsPGGtJa+6pXjjQ+Zv3ZwWm/129TFtQe92JHzBoQELIlzl9/4uu?=
 =?us-ascii?Q?CTC4j2fuq443NM1IecRsUHxtzXV0giWlXD2CZQFTl6VSe0sVL5+XR0tSSsCE?=
 =?us-ascii?Q?R9I0wW2tIUx6EZxxnAncRFtM62f+zRJF5jLLGpjwEkRUcRBNnMnl5wQuX4xt?=
 =?us-ascii?Q?AZ/a/fqaBuUiKX6Cg5sdPSzwxMNf8nFMcR+4+ty2bZsjIxhd/PHIcs0CjZI+?=
 =?us-ascii?Q?skY7fy4TpclQ5trXfU5TiFl5dyOugaJJvrx5Hc6WQYUZuXXSUQyWoT1RL7lR?=
 =?us-ascii?Q?x9Zi9FDeoOlKVAql1Qwx00kVC+Pnmu9z0snkYEHtAuJ16ikLMgXRok6e+b7y?=
 =?us-ascii?Q?KHAfA/52FEeCeLG3+DQaUprEx1FcddYC3qn0LiNw99dQug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4111096c-9ea0-49d1-e080-08d90af3678d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 09:44:37.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fFZlor2MM3Yj9vF8r7Ascbn6sjmbSLRUxFMCntXuj0nOX3d4LfxDXIGkYokS6DbbCOv0O7RN7DKpxJ/8eGnJ4R+GhJwIG/595pQ6xO5POA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7304
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/04/2021 11:24, Filipe Manana wrote:=0A=
> The use of _fail is usually discouraged. A simple echo would suffice here=
.=0A=
=0A=
=0A=
Need to do echo + exit here, otherwise there will be errors in the shell sc=
ript.=0A=
=0A=
Everything else worked in.=0A=
=0A=
Thanks a lot,=0A=
	Johannes=0A=
