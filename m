Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672B336EC42
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhD2OUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 10:20:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:1172 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhD2OU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 10:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619705983; x=1651241983;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GhFO0AC0VUls3ypiQdNTX6CsPQtj6UTB9S4uDUHrGouMVUB8RiC5nvIG
   raActVokmAaMGhtAQdp2mdNfJkQbCapsYBwxFoiSw5PqiVI+k0CLdzECL
   4ia7al5xN3t0TejPd1enaWZkTvzlHZ+oQH1YWvbYQdq7qTbaIa8pnwKsX
   TJ4wOGHG84NEfV4qcf8EBySeu572zkbXDkiHe84ytPK8zLHmayLAgZfmE
   EAQv2kKZhMDc3LIqmzofOPob1e3fheClcVjnKRY3L51rC/BjGqct/RKQ6
   Uwj4nfLeXeNGSaUiCw0DTtEuCo8+KPilCHimqcyD0yXtaiAfbo56306tB
   Q==;
IronPort-SDR: V0COr19eVshgb/K3PuTGLdyPe2RmnxHYgazy01qbFmUpwptN9lZAuB6E7E349oJMtExjisULgy
 76aCLCEpbBR8B4ThSajgWq55OP60ILI2o0BgOsHvnx7w8Hp0WdwnHzuEShmaFt5JMtxPVZhKpL
 1V93y8+sR+946YSwxCxjZVClGC4FpQxgoRV3mWEUa1EutDm1GOLYdsSepdvxCrBYGHEiTF4iDx
 g/36S6Y2N4mrC5qDeB3oISKECju1oVXKeSERtulZzk9kr2iS0neF4WwoElFdV4YNMfOpxUYpek
 Lok=
X-IronPort-AV: E=Sophos;i="5.82,259,1613404800"; 
   d="scan'208";a="167204101"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 22:19:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiGg5DTmjZVC4D8tIR5hkcpZ6alyWbAg1ymcSMDKpVn0Y27ZnUFyCywnZtlI1APGRYFXmmhBr3E8P/erJD5UXfHNc0iQx+53fID9iL+2VOuIVdroKTfdPWPfXVvDSCcmaMf+FHS9Lpqk04D/uMV797IHIBE9z4VSxdkTygPv86MDvaZli3gw656HhdaNtKOhUw5gRj7aST8BXBbdyruQuIekM4XTw+76NG6Kdi9+CbejRSBIlmsUhSLQQ3sycJxnKYDTejirhFp+WFWkrX8697eTPTQ9Na7uY4kUUQhh+4WEXA+jSCT4M3PNX1VluYxE5GbE+sgTMxDpnnzP6zDuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jHKTrgtiwOhmLXFDmvmcNqukBgzsiaJGdNFnaBQ81crbvujk8mGZkmtfCLboGdAjBdxK2yfuYZeLGsH6iEaSt37y21qVne9NzYCmQ5jvTuE+/Sx37ZM0JxBU6aCX+AeUgxs775GUDQ7EHn+mLWBQ5XNts5EniRfT/4a2ZR44dMIM51fmKJGQrxlV/iRfoC+64+7Jy/RoQTMUrB5C5gAFW1R59Wyy6LhbIegNAvKjT9ajzM/mTer19ROzvxr8vGXeppozgqPP733bhk/9jBODH6snd0cWqcSuQRH7IVrTUYjVgxKxT3+E3N/sbauKFWSHOD8lkViZINrYI42SpRTm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hK65r8inwNb2GEuqRoLy6W+1Xg0xVACmwlRN6s/BcOnww2DSmQeryasKHaJgi50TpC7Q5Mo6i+INFuMYOE5GURepAnvmHgKreC+zNXnDIg+lr68YgdLg+SCMaSiW0IidCddRM7okNweN6fYzwWue+G8n6ImIiA3eluYqYCK39h0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7192.namprd04.prod.outlook.com (2603:10b6:510:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 14:19:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:19:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 5/7] btrfs: don't include the global rsv size in the
 preemptive used amount
Thread-Topic: [PATCH 5/7] btrfs: don't include the global rsv size in the
 preemptive used amount
Thread-Index: AQHXPFWQjY7S6DJCRUmkF8VJ1jFqeA==
Date:   Thu, 29 Apr 2021 14:19:40 +0000
Message-ID: <PH0PR04MB74160D8C3722037B49E4C1449B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
 <612a917a29754cb8f2745a9d45a2d78dfee538fc.1619631053.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:a91f:c11b:e39c:d980]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f69056d-faf0-4658-3e84-08d90b19d3cc
x-ms-traffictypediagnostic: PH0PR04MB7192:
x-microsoft-antispam-prvs: <PH0PR04MB7192604280DFC82CF9D41FF09B5F9@PH0PR04MB7192.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xloh91x9EZpxRTRwToEO421RI48hWGRRNA2T8U6Pt+NVixrtMLSURqmqEN9l0ELwYeO0oD9UTtMxLg9e93Rjg57tmUXqxafvEOfHwTKb1S2HPrmDLGXpXeNlw6/pRzzqBGqDGvC4AG8RaSZljDqj5LSUitXsRo139H950z8ioM1r+979NNFvr17lPtSupI+KpPRtMOOSNiQAgyz3X6J0Sg0qqcCwVqJfOeaLfxqzi0Uq/IaCd64JfNiQ4BT1s63Cllr36c2YOI0P1uBNS+Qlbfb7gNJ1cg0zjOx0ax8pSQY7BqRB0FGEOoi5HZ9U3jkM2q20KE012t5u2DwyJac1fktxANAO28yYUOHuVLTVDpQ6KyTqRAKldAc6h/Q3ez6CmM/uejZuriPRZxFayjRPxNuhLxH+ux6N+yxS5mtFSGHa8KrUNmA9GelUKnL6x8rTJdyifX8rdV9PV1N4LjrlYobvTxRBYxDGCI5Vo9yPMwxNaQD/QuTLROSmL24RuKwGgDb7uRxgGfNuKFPku9QyOtXQgEkngQwHqCekVQBMWhIV2QJkOHRq6/q6A9evMJAy3tclCwT2Q6M3YFhkm4yXgobfpp4KG74tiYvI6eem3G4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(8936002)(76116006)(110136005)(91956017)(558084003)(2906002)(8676002)(5660300002)(86362001)(33656002)(52536014)(66476007)(19618925003)(64756008)(316002)(66946007)(186003)(66446008)(71200400001)(38100700002)(55016002)(9686003)(478600001)(66556008)(7696005)(122000001)(6506007)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xBd+f5IG2hQYFFbW2JbrQx68ha6VnaJmsX08UG5NMeDH29KGkQCEHcOoWnQU?=
 =?us-ascii?Q?uQjKlAyclCz4+bieh1i5b+FLxT3o+Iy5NUPaId1IkH5rRx6J3XCm12n0cfpk?=
 =?us-ascii?Q?pjjRT2ZCv2dcbziIJtko7nq4gw20j8cl8CKggPbAVgVAJbNOKmeYGa7+sFRy?=
 =?us-ascii?Q?t7/R9OHWblEh6qJihaiuy/BR+tj1XYKjyCprvdCjIP7TZGRJD7yn/t1hByIl?=
 =?us-ascii?Q?jCRw9kxJLLT/E2lSwRifkS0j8q3syvJrVd/YQ9VR0LffXMFpZat76vPEVDBq?=
 =?us-ascii?Q?inOFRWUORhqzY91lZQv1rp+HHsNnY3UbEog+wNSJT/fa+lDl1uS0QqAdBbXz?=
 =?us-ascii?Q?sYPI/xB4HsTbyGkfDj+HYobOag/R8TSlzzgnxBnaOfrtaZ1khFUEddaNYvAB?=
 =?us-ascii?Q?Bz59n4OBcwXbr/H14Jl5CyS8GHMXkFWR++KUxewWse1m8NJ1mykSWfbG3NhC?=
 =?us-ascii?Q?Z08iuqS92ff0lLm9mAwoB6JGHct0fNNnRc4gCQ5P56WklyouNUR++Ofjwvbe?=
 =?us-ascii?Q?c5SxrFaYflpfTgcF0vCOUztUcseMy4DOO06FsrTamzByfXpigov+ES9XE7qZ?=
 =?us-ascii?Q?TxHDJGRKBXnH2nM1nAghWHfVADaX1x5HQbfmzlzlHzYQXgToJhh5KtWlJscP?=
 =?us-ascii?Q?7hPFi7UWFCIG5wB2EgCNGr6RQJHYKs9U+OoYOtvTd/0zGtba5O4MkKOkmDNQ?=
 =?us-ascii?Q?a7+esHwn8qiQ/A//M86P6dCGvefjl4RCUqCssypo7WStQagcjFl17kLkJosm?=
 =?us-ascii?Q?cWxqWMxEBAYgBK2wEEKGmlwUQ6p3tdReGhzsHuvVVmymVjyYwRahYWGjdlBF?=
 =?us-ascii?Q?faY1xtdxUVqYQrz59uoNLqsctH/njxFWKQW61KFS1fPbcR3BWHBq+4cBA5Me?=
 =?us-ascii?Q?W9f9EDRQNusbS5Ap/9gyjw4WCupjUMTtR2kliQsqKTJUxEvqKaTZ4pjpgbpf?=
 =?us-ascii?Q?1I2KQFlQ6lAT3ykzUYYOP39XX71sSQ78djyqr2tyGXt+USPsABm9+tIQ43rn?=
 =?us-ascii?Q?L7T0Nk1iapQSSfBw+PK6kdFMyVYKTWYVxSk89ciE8SlY4ay/CfNY2z45gH+b?=
 =?us-ascii?Q?oQcn2NH3NHaVw1URhZU+6ujH+IbAT+jXp7eQraS6CNNsWI6xRYwia1Wbh2t3?=
 =?us-ascii?Q?THSyoah9Cv8nib3IFk+F5SVibodBdaGw0xQr8WuGvVKLj5EG7lK0xE4PelDx?=
 =?us-ascii?Q?7p6zIvEYwb2EGb57m5ENocDPCjQYV9UHrVHa20FLjK0kRM0F6cCX1q+ZurrO?=
 =?us-ascii?Q?lI2P1+3v/Oc81GlW2q9Ynbnb7mo6ST3cBT6lzW1LZ5GedKLGY+X05ay5x/Av?=
 =?us-ascii?Q?6YM5ZrFMq6aT4kbYSKMfzroC/P9FGgYCIarZFdebrieV7SPJVfa9j33gsno9?=
 =?us-ascii?Q?eaW242MLmwJ/wZaTqdzFsBJpVaQlBcv2pa61Cqr0y5FZ/zxslg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69056d-faf0-4658-3e84-08d90b19d3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 14:19:40.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2FLCEepHUWxOYjJNmSjb+xIwSVuYlAC2/FlTfx4paD6sct18dP6CHovD6tLl2KsNRdta/SeVNRkteVwAdPGCvxofgshm41O6q9HsgmZWa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7192
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
