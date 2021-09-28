Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93841A904
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhI1Gie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 02:38:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23508 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Gid (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 02:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632811014; x=1664347014;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W4kA+1InYadBbkxjPKHqfF6+MXb41HMW9zRVSHIDvDE=;
  b=N+WfaREUzTl/FXm/r7Age+YohFhmPFPNeM6CwRqCyAUSAjT1IcbagK7F
   QVKutAtcLy8/18hnaQH4oHQJPJdNLhUPM330GjCpoe44xabHzbPyhTfQm
   3rxl8zh6in3zO+HZzpjNdzp6h9AeVkfjkSw+WLmh6TKu9BQQWEkFGwj4l
   dgn2lnIEWZJ69RsDlhINsZK3lS41PiBnd9THvHoTKaXG1yH+XNsq85jTM
   xOlmsHYMs20WxHzaMLhvyL1iXP9n8h27qkVOHC+ctozLlK8ItLjwMv8jh
   qpKBnUkVuvisJblKUPoNKQUjba3EE2sgMiN+qVHGtB5YK2e+GMFGfWIe6
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="284953688"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2021 14:36:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEGryXwCjDP31sUCmiYJ6Ydg3twOiF8V/E1DBXC33IZpm4xb60PIGPyU5IsuJ9W3Vf8ZW6BxRZiTy9wj0anSX2d1bkpt2NBzrWfpiDSrVB7LvegE3ZUVuFq4AUuS2JP8gnf2tw0jTIdNVYn3i4iaHW5IqiycV8peOIgMkR94T8BnK3clXwIyfiFh2Fqq3ljUovyu9dBJe/iaZ7fhdNEAbID/3DeRigt4NWH+B9K+x1STTSgDAYUBpxYtxNAAGix/rHJSG6puWWSMVrSBYJrJ/Ili/CHCAwNPvHexYFEfnPCExslne5KlI8JKBfTUmC0jyfodOHrQ4U2E/HoLVaCq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W4kA+1InYadBbkxjPKHqfF6+MXb41HMW9zRVSHIDvDE=;
 b=nxrkxo9tFb+4nZTbAludja1Dkr09KmaGYrkyX8C22xio9GiRtgDReSA1CqrC55gtw7CcaI+dkSmDl/uR9+zgKCU+bNNurgCyWCIrYqLPbbzOVGUw0ahdh8L+cBXi2r5EdF0Tdaqx/+lhS/TMv5r1GWCU5A9eeKttAyLIxgcU7y3WL8JbUNBmQ0eh+uTYWaKj4HUpBoaNKb+aTrnrKbM1RHQS4vBjAVb5xMt6natcYXbTePhbEyZ4LVUWC6qDHqJ2umjVj8WL1nRqlGSBE4GDAOxGndkbX76xqn0hUmMYb4D8tX9V7Sj9UuW0DSmgKlikDK8aCqQgqnjnDl9jXe452g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4kA+1InYadBbkxjPKHqfF6+MXb41HMW9zRVSHIDvDE=;
 b=grFCZlUEE/YbzIznLmQ/aoPWs/XGDmFeGRF5tr88q3ljAFT8fovG3LzkLevYHSftQtHLWjPwvcoJnFwAoQRq7qQXAnttUlY01GUjEegpIxjaeySkLx3ku3sZWpQqzxxZcZMrcy5DK/O2BAfVmIYx2o3mza5lMHBMn56Pi+6tvjw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7384.namprd04.prod.outlook.com (2603:10b6:510:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 06:36:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 06:36:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sven Oehme <oehmes@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwJGr/oBwu5kOQfX1ME0hbsA==
Date:   Tue, 28 Sep 2021 06:36:51 +0000
Message-ID: <PH0PR04MB741686C587780B61EEB337A19BA89@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
 <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
 <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com>
 <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com>
 <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com>
 <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7df7bc3-1864-4919-b17b-08d9824a5b41
x-ms-traffictypediagnostic: PH0PR04MB7384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7384B96D5A8E5750948D49E19BA89@PH0PR04MB7384.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jdXtDuWMhdi1v2nZqrRK153Gz3mke4ZGOIkgTAl56pEHhwomNxZAMoUbOgi18gTL0wgxxsoqtE62p+6zDpHoH/Af4yaqO6vRcW5dJdnBEfzYHpWD5afGlzMWf6ZU8/pcOW04Btv13o2MK19kmlbaj1iT5nTFDFDllcXwqAXp+VAS9NDDWqPwQnqC1H4x6SBYSga5YO/uDHJzgnosVvQ+7oiFFsGlAbbuK9JPsbKNyPbKMQ0s/j8dy+LxQXEgyUT+ZIBvUvElE1VNOJHDt3I/Kk6shzRiu4TeRgPenOVrjNtGYJFD3eMMOm3obIiI6YeRx4Jhm/zr3qsd6UI5O+CAMQl8ExKOyMI/9CVTa774ditdTgiHWOgab+ttB4XCM3B9f9DSNdNvytHkf6f8PPXIcrzzW0MAsGrWK/Cg+0DF5qqhy+PDz/prrcPVh7RWEFxSg3FBvOaeM6dQzlR6nJONnuJ59jadyVbVYL9Xvuq+pc/3DNs+G9bzjtU0282wGR6gXArwdvs4ZDWkY8wtrVKJd3X5W3S4zTBANrFvFc8ts0If3CHDnQjqhq6/LipgFhTK7kYSGBE6A5xGvgy51vjzx9/ljzphwZ0z4h64jw7A11ofmdsIes99evYbC4BU8Z4pyFzAbZ3CDTdhJqzaJFzpE2gDPQF2ONbqNafDkLQW62z1s4LNJgqB1rxL/XeglyQItrFGODKeQGYWwTCsC21R2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(55016002)(9686003)(7696005)(76116006)(91956017)(66476007)(66946007)(4326008)(52536014)(8936002)(8676002)(186003)(66446008)(64756008)(66556008)(33656002)(86362001)(316002)(110136005)(38100700002)(5660300002)(6506007)(4744005)(2906002)(53546011)(71200400001)(38070700005)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?maHjK/MAjxLe+JIOyQNCgXl9w9kOUR8pkuNMKQgpjv+jruU4EnxINev5vcNt?=
 =?us-ascii?Q?Hj07LkpX+/qNkEId8Q/l9pEiFmVazG56CtPpfDFcCPmEE8rysUAPmCkJ9nlX?=
 =?us-ascii?Q?XRu+pLObhcedWMGI8lre56VnQYLtmcKSW3iNWvFg40s0Bmc47RC35XCcZ9wQ?=
 =?us-ascii?Q?lcvF/B8w6FHpN23nUiN6bju5rCHO9IO/nQYm4dLynpct0f2+2lfKIW5usq6M?=
 =?us-ascii?Q?Ny5rwjbLFM+QMZViWFZrESIQSwp4ywLJjFOfKufeLWY/bp3nF7etLsnGwOVe?=
 =?us-ascii?Q?yIZk++SXLQdhFtOxlFlMD/zD1R7gmjtzpvWBd1PJohb1uL/veqe5PDqmycO4?=
 =?us-ascii?Q?R1E+eooSEteXZX8DoppgyMIzwt9q5QeixrzwOgaQz9maQRLdXStxod40RsRZ?=
 =?us-ascii?Q?y22py7V4aF2HrSW8hGN7M8Jd7sCy2i8ZOKgdLFBVjgUbb+tqCN/XPZhhyovM?=
 =?us-ascii?Q?IUaIbFXeR9afKAotWC/BiJGmxEIBZeR42YqooZ2texnEuHlvxuKeZnQBQUMi?=
 =?us-ascii?Q?DHjAW+xA/i8RGGaevukQ+zviouM4EYLO5/uiFZjrxJ4Ro11VSKDI8DarM6n2?=
 =?us-ascii?Q?QKidD/9vuq4f+PV4LYNEWJ1FFPVJ2TuFpZSoTQI37w47vLDnzWrxQI2aK5Cp?=
 =?us-ascii?Q?oLfvWTOaFEWU/T2qYa3JvzOguqzZL6jvoCpZo1WrVEj3GHv0Lf4njWFAjkPX?=
 =?us-ascii?Q?O33qZT7avmGubpKeJ5/beEGZj0G7SfCjTydLLWCbQ6TywuCd1aA9OvmNGeaF?=
 =?us-ascii?Q?VZO+RaDm2JfhL5N+xXWsR8da7qK/y37Zn19oluk6Apn3EkeFyM/BcIOwwQhw?=
 =?us-ascii?Q?/zbtRiduijusoJB3H1A/02Jfhc0pF+nJhybsPo9S1PzXPvyNl9NZSx58Mdw9?=
 =?us-ascii?Q?42X6zeK3jBgctf941TPeIHZAhuvTcXdaAMKoS6SAdt4C3kh4BU4fKzIwd1xZ?=
 =?us-ascii?Q?vkMtzoYyAScDaABVy9tW+KBcZGMz7f3yP4e/LxgjlRmBKiycjA2wtweY3yKW?=
 =?us-ascii?Q?7yHJo5QdWfP3gnIRePcVV0rJ3GItl9ljrtyi1js97ljBmqpErW0wUpqBI0h8?=
 =?us-ascii?Q?rK8QkEBz9h8C0QCzkyRF0SRHHXrx14LWM60wWZhcrCxLrCASbwIN/8ZTCHjt?=
 =?us-ascii?Q?ynrB4cEaigNGTRDEe4TyWVFu0KpsQdYuLnPoiQan2uIA+QoNHDVVMZl8FPUo?=
 =?us-ascii?Q?Ydvd9xf4pPcgCiClxvdgwgv0G+HdQX20LEff+mz/Ukbvz0yOlo1KWMj4fBQB?=
 =?us-ascii?Q?rKLL8aqAQUBrFD2hGerq+FuTlKvK2cWmQvEFHfrZTBy6Hif5sfp74Ykkq9UA?=
 =?us-ascii?Q?Gsl/hsIU2SxuHTQd9coxz2gDOoTot828IVgysUlFzkNylRbC/XuWcHWvdHcU?=
 =?us-ascii?Q?PYkbIKj5MwYIv61xcfJbdINU9d+7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7df7bc3-1864-4919-b17b-08d9824a5b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 06:36:51.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1UL7din726MgRSxRw5KNcdggbohuqsYrnH39kvRXg/3FgqkmmE1d6rtAwyRXOdqKCtrGqsl5GsKKj2Moar68vkHeY4KROuQVBAnhw9R5AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7384
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 01:34, Sven Oehme wrote:=0A=
> the workload is as simple as one can imagine :=0A=
> =0A=
> scp -rp /space/01/ /space/20/=0A=
> where space/01 is a ext4 filesystem with several >100gb files in it,=0A=
> /space/20 is the btrfs destination=0A=
> =0A=
> its single threaded , nothing special=0A=
=0A=
Thanks for the info, I'm trying to recreate the issue locally.=0A=
