Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A1826C083
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIPJ2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 05:28:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37639 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIPJ2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 05:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600248499; x=1631784499;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=nl/gJXgoRYrATWsFmpXeqwdmTAITMHCcu1McfPpbxjv3DGPpGrW5fPnJ
   twz+JQm9LtmENlfeLaRMGt+xA3OWxtoK5VLAyg0AdvpsqG310/2pu9ZjZ
   nEAL5vgwYdBl4lhwQ1j9d3FB7Cdmmf89cOtfcOY/oi1mFDCFwdrJgAm1F
   W/pnmBvEGqPorqb2h3ozeNDZTXZxD+k8A+F2fzlcA/RH2rztB2u0swt3N
   N+xIBHzQkKjGzyk5+06Y0SmkLk0dqN2FO5Qq8xFC5DTW+fJ57rtDPwujE
   ZJABDfE9DQHbcU6WXOutfdo/saFa2bmSMSTS2oqaxewwU7R/kzHON/vY1
   w==;
IronPort-SDR: OnxtvPXTlhfSCYEzcg2AvhXxZpxOI7ioVtXqhNM8+I2Z5czJmYcdKUeuWsr8yLJOnEZRrZPedU
 dXQicl2MLcf5MjtHIljOmmP4YKUWdSc1Lr4ffoDXoCi3qFM19pUihvZv++dswPCESQTuqHd6t8
 cyOH+D0VD0Ta0Wn69G1v2zXYRdrdeqLXAxUNZYsk4jelqdeWWYADQf4u5aqh4W9RxcCZqjqMN2
 ZsH8t71DweANwT0aQtI8RMO1s3ZzpQvI1cY/EpiklwgsA9XjF4ZAL3MaeiOzG5ldYwJ3c23U1H
 INE=
X-IronPort-AV: E=Sophos;i="5.76,432,1592841600"; 
   d="scan'208";a="257159672"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 17:28:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOnsI42jLlC1g3XiRvkLVzWtiWwyM7ehkPLMcmwd+K1ecTU/zbcB3QyfUq0OLcIt1KdBE9Ow1OoDTLSyna8l/RzCPDwFSOsmZHKbzE/gkz+HS9Mesk0R4b8lQlt2UGZNQueA0zy/Ow3BfHuxIUB3oticGyjv+Ep11MHJbTzKVCvqIF3DHvN1XMO4rJiguENhfrN0UPJ7Mmd/QrlznISmlXjup4Wbbdu1zmvezy+s3iJlnwqj0lBIh3XQhSLRJtjerQArCJ3WhOJ7fAWhG9/5MC4FcGLQPkYhPEwmyMnezEzvcedBDkXBOyYfcgnCrlRKYhqotscIcWVmSOOo7GZtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=bv9pnsDReaODfdZDtWymddk6/3qgo2NCF9yvivnlCIv3M2vIJEn7lkYNEAC8/Oh7DitT8n+Dk2vz6v+Z/BZ1bfOnihuhSXwNhy6T+9v683yvaiF0cVnNXpoaWA76M4GEzMV89aFgQG8mpXa1KiACupBLPCc+KYbXYkvFbriRqWFzbAE0NRjdPa9j3T8DefGbtc3Mz4v1XF+/3jKIUfXJdNQyF5jWg5NmqwAOKdbU1Bw4+Zs6ymSGlESWZbqsG2LZDRgN/Df9+KN1Rp/e/klLosrcTugrFewSF+E53fAkHTwW6XCU5Wano5X5b1rqltX/L24KkHzzONNWC4Bd34nepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=Yph9bh/MkaHQhRBeJHSAwAUJPasXH70pRiDzM28CJay/a7uhFcNaBAUlly6QA0EfRXvj0MNsv+hbku43R4iyTS5fArbJVjvssUL03Gjg4Gn3O2P1Ja4kuGvIXC0ygdScA0R9ZO+mIJoGWAq6E2QlhVdoPHGeyidtXX5AbtIZSko=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 16 Sep
 2020 09:28:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 09:28:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
Thread-Topic: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
Thread-Index: AQHWiyIl3pr839Wy4ECKaZNUQTUz6w==
Date:   Wed, 16 Sep 2020 09:28:18 +0000
Message-ID: <SN4PR0401MB359855CC740E3361729464D79B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c66a4e02-1f67-4ed1-af09-08d85a22d8bf
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB3597F9FF0A939DE5734F46C99B210@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRNINTI7O9Zt0b74YIrCtkQOnVnsebZ3vDnTccZzVFU+fdfrSWips78UgdJLRh/YZVoM75VQVcDZe/zLMEFhoJEp1lgQWUXfQ/2mdqzATJqosYaVRu5xPUml9FnI2CS57B2Jb1WndSKEovW4lHe1RRUDXhHCrkR+CZb4YD6okSoR98MGth8WGW/qYWrfZNFzwN38JmTdaih3cXUscdFOBRnQeyXcPteDNw557+xnchVgBzzO7o7VAgH/RGhT6el06gIbfuGABLUkMjbNL0+BV19BChSSOxUO5EL9M0gi9wavHsEayKtB9nxhlJoVd0LSX4T7bl2po6r3UWF4jdUV/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(366004)(136003)(396003)(376002)(9686003)(33656002)(66476007)(478600001)(91956017)(316002)(66946007)(66556008)(19618925003)(8676002)(66446008)(76116006)(52536014)(64756008)(55016002)(110136005)(71200400001)(8936002)(86362001)(558084003)(6506007)(4270600006)(2906002)(7696005)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N9VxQpt23/115hNvADKt+PO5qQ5GYzFxb8teE4pZRaNoRnyUN8TeTKXhB4EhCf8DGjHvWt/jYtNlcEDsLHSXgW2t4kIaNUaa1jVwDu3Pa/qIk/XQ1RBv3JIjkGqcSsu5duA7y8xzU0imOE/CbNLV74gh5xaVXZBrPZlTXjaLfHhHqJnOTynfjsv9ggHzBw3OlSLIL/IzjlbFzWB6oc6C16KCxclizsA0EeLM0DkU537AcjB+9vNA00bOEy/ZSOk15NaFkFId5J+K5EMoScCpF4tidJetMlWlPs6Ks4I6V04kylOtgABOCrrUpbOne5ehH0QcVA0AGweIsAwIM5qoQzgDOyYIeiAS7c7J8j+m/7sX4BIbue+pY37VbqEOctEGxp4kvbrrphYcecCRwOG1S3Fqla5XsAmEzEe2EriSTUs8BXkjjAtc6RFFnrL8IVykoZZGZR3lPSB723W0iCqj6BZ2v0zByMw89c+Oc+JaP78FK3e1WF8UQDKJldGK011wzmgxbRqf/9I8P+wUx8UN4ZqpDPGbSxa0USwvi4PiGHpoWIzpPf77U82xP/C4Vq90rD9dAtyMnZrcwxaK27XOAncF8aNqCIPKXZaTPEh47X+FMNDa0eUVl+QFVRCPGST0zg6QtbPMVrt7o5RumHrZgsCGXgAYywFOqNs2WHCMzAz8kSNP5YjCNDuGj53dln19BufrAiiu7AUKPwNiLhE8KQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a4e02-1f67-4ed1-af09-08d85a22d8bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 09:28:18.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avVDi0skFVAs722qHCiNOyQHbmSXU49WjaC7fUoIqgOyyAbjic3EFIzp311o2jTGZUvnwjxaEMBEPxChZwKEdPymgCq1tfs+iuQ5baT5mrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
