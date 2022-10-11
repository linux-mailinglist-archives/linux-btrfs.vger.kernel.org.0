Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1465FA951
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 02:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJKAbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 20:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJKAa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 20:30:56 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f403:7005::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1C61D7B
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 17:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx/DtHyXNy9MfFDmRFO0hLzo9VsUPQyT7dtMprOWk1gm6fqOG/+WltOAeiUv7udIZ/d5aeDFAiWud0cEpwj3tnYkL1QEdih4c6kwtYYOozwpjGsnGl0d3dA+UkRMQ0B5rc5EQXBmRTkYwWH5eDm5cXY6TBiSFberw3V3rtLSTUvZrk133ANS9EiWVZ2vKF8f3dzKaR9WkGOb8zciPz2ptAT3P1giH1ICUytI+fd2TeDBfLJ9Ehor/55y8+JkPENu37AdlVDeg1arcxnQntxGfqHnNODJQc7Yy4xhVQRmICWwJ0wk9EPwXXfJ2GaWwhQCMSZiOIrZyMDIkpc/gD6org==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW3qvaj4TXRkJkCVzEZcwhx1R9Xh4/pGEdFNlN0erU4=;
 b=H99pUaHi89unHIfZdmnV40HuoroJGz0C5fgJuWinzV9XnuKc/drd5mbYqBv/PQXeLUqdiSHF9Wt93ufK75lYMza5mKH85uUbbY67i4dbVOzzTCmbqcoWrzQbV1is0tww6YpQsgRBmwtYfZZb0Jzp808WsjcQoukh56mhcVTd0Zx0Sl08LMKVFXayrGgoCgufonR8RQjI6obYL7A20mwXs5nmfAnamADHTLrcSHY32xompnaXLzEDiagkT2/bp4qQ7HIxgnk6XDSv4BMKlcvQKXMlTuOUKhfzG2z2YahuTuQjhZJOgC9/xxW1PLU/ElmLRhsCdHbbxMK8wK/OmFrHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW3qvaj4TXRkJkCVzEZcwhx1R9Xh4/pGEdFNlN0erU4=;
 b=WTABSZoYqbfIOV1bdVoDtdxY519RaxRfqM4UOKFXZYO1UtzuF4nY8YpOU0c2G6EzcgOBYZIghXidDIA7gFeluZ67FyIUIfp7+9VwaeA6heIgB0Pr1wpQMMqD/NOEsDhNnU21uZ7NHDKb6NmLvB9N9qiq+nd5/p8ZSmLUoIuub54=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY3PR01MB0828.ausprd01.prod.outlook.com (2603:10c6:0:2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 00:30:43 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::f4cc:d42a:dac2:ecb]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::f4cc:d42a:dac2:ecb%7]) with mapi id 15.20.5676.040; Tue, 11 Oct 2022
 00:30:43 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Filipe Manana <fdmanana@kernel.org>,
        Glenn Washburn <development@efficientek.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: btrfs send/receive not always sharing extents
Thread-Topic: btrfs send/receive not always sharing extents
Thread-Index: AQHY2ttAcp72/RZC/Uy+gD+isVcRH64HY3UAgAD3lrA=
Date:   Tue, 11 Oct 2022 00:30:43 +0000
Message-ID: <SYCPR01MB46853527E05CE137D9525B1F9E239@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <20221008005704.795b44b0@crass-HP-ZBook-15-G2>
 <20221010094218.GA2141122@falcondesktop>
In-Reply-To: <20221010094218.GA2141122@falcondesktop>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY3PR01MB0828:EE_
x-ms-office365-filtering-correlation-id: cef3a093-6eb0-4343-8c63-08daab1fd518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDSokYtXk8R+I8Y/BGBwOs3rc0bn9fJa5gkc2Qp3DFvACdhCpORPZmbERd+V5Zp6QbqoNCxoJ+fyRESbKwCttD3au5gWJxVpDNXwctwOTbG5KieqiuPt5+xSZ9O73bHxWW7DTuP3JsmdNIcrVatOSdTe8LzyeHPEu0vk239dxq24EPIwua40e1FC9ilkUV0ZRwvoVP0LFnhceFRVas2r6lb74m9JWS0vYEwjUihg7nx/+hDnqqLBa+VYOx+XvVCbuiGDW24YyQAaj8xxWA9OjAu5n+1kT9D1nAP2aob3qRLDl2XGeas//uGjPx25PL/2suP4HHnznHl/eDBnXr2GZsBfb4B4qp01G4wVc06cUdlTXmCxIkbgk+slQZ+G+QIGNoJxBqf3HuXE/mTNSpLCeptwV/MImoiAdF1esVrTeyzj6ommv4Wm3QjGuEWgpc5fNrqhv2XowL7yys+nCbiEiyu+ZHcOSeTYEGL7w30JcKvMgj1gOeTubVQhL9s9YI2O6ImgA9bLmuWRFzYrtulB5kTjtkh4yNsZrZ2XV5GWVtNcd2FPgTxrys0B0z/iUohVsbLHxmcJzbJIu/2DfHubdMpccpP8i/CVkkZEh5F39UM+UdZDGefWyvVxr6Prt5hOOUhgn2yeAjmp/3X4mITnahhxzTIMQPXNvKNzjUWul/oxgMFHK2tChlDrtaDg7Cmc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(376002)(39830400003)(451199015)(52536014)(66946007)(64756008)(4326008)(8676002)(66446008)(66476007)(38100700002)(41300700001)(38070700005)(8936002)(316002)(76116006)(5660300002)(4744005)(110136005)(478600001)(71200400001)(66556008)(33656002)(2906002)(9686003)(86362001)(186003)(55016003)(122000001)(83380400001)(7696005)(26005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: p+dke9tYpx7Qwrjo8IrqctzXD28DhefV6PnGjlCVKlPF+CYnIc18fAUoSF0g3QVKrLvgB69POM7ezONcZ8AkC45yrcxehrrr1NV1wzNAbit5f0uPz76PdLIvyahlQBZFyaa7cbbu/KXJBRxQ9aY36DIwrIUzIWJX/RJHyMHDVY4K6CY5VlTTLCas8LCY/4fWSq3zblp4P818Frz5P8X3YqKeVWrxH7dLNZj/1EsfnZiGzF5fryh0tGGDkXQmhjCV9fQj7ICgwuLkiM4JVHFUZckmnNkmEefgFLSFk1T6C62fd9odG0+yj9alkQO+NlxFoOEqueBhcnhn++Ph6iHA3yMI9V/X/rAHYa7bch6Qw9fBqT2Nb9IyiAW941h0t8UW5sEa4rfDJpDthuAb3D0ULZWy8BlgKdmrfe2MK6a5xRc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef3a093-6eb0-4343-8c63-08daab1fd518
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 00:30:43.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tPbgtq0x1R8lcimLVmk+RQe/gNJCXCA7O2lFtMUCH9UUFDBW8tml3Y0KjJupI60Izu9QDErXzcc73Ic7FoCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PR01MB0828
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Filipe Manana <fdmanana@kernel.org>
> Sent: Monday, 10 October 2022 8:42 PM
> To: Glenn Washburn <development@efficientek.com>
> Cc: linux-btrfs@vger.kernel.org
> Subject: Re: btrfs send/receive not always sharing extents
>=20
....=20
> I have some work in progress and ideas to speedup send in some cases, but
> I'm afraid we'll always have some limitations - in the best case we can
> improve on them, but not eliminate them completely.
>=20
> You can run a dedupe tool on the destination filesystem to get the extent=
s
> shared.

Is that possible? To use a dedupe tool the subvolume has to be RW, but chan=
ging it from RO will break any future send operations I thought?


Paul.
