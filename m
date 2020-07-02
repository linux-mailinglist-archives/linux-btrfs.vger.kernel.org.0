Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380732125FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgGBOTZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:19:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31213 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593699565; x=1625235565;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DmnDN1XqyzFk6is4ymLetCcmwI60CxF2+AzOGa6tvg//DxSYA4dg5kt6
   XB0Md5+KKSM/OzdFiy3Vdw1mij5frI/qXQH6TnH+KpvemsUubddHYRYjn
   3FxC+KJg2xEhyFuHZb8rGU0/1jcH1pRDKA2511wu0lQ7D1Ig5PM5l0r/o
   QjuVaTrJWXa/DLoAq8ginRzxAvkHwm0mbGG205kkPdcvLojgeS0Zp41ow
   ZNQ+tXeJnGrpcruhEi0YHu+ACkcBbVRcN/llZ1sJieIeLi0zQAz2OVjqU
   llFFAn5XgRG9OCfXHedUlg909mP8wRI6nVHA3BFmMW082NYshsV99qtFz
   Q==;
IronPort-SDR: ys7Y1xBtUYWy2OQxrvvgeRBsh/T5JEo3c+LO2i0VGLI6rGL5RD3I/N0LK3UzPDZSM+jpU66b/m
 349MYJitPHWWvmkrb5zh2pMWcG9mE9IwZabZrjDME0t+PtplK0Kfr/cz7V2dIDyMrAB4xD3Tp4
 HR0+DHTezlPhk1l2mzyV4lzT47XlOtxyGRAyUNDW8NQKHFERlvDb3yxOc82cGXh513qwkS1ogK
 W2A6JQyFLkTi1tL/krlcZkY+E1eDtIbgxrsdrblt6YIGsUVZIDEwSepVTMy32mC5Oul1ojJZP1
 qoU=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="141684148"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:19:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYOWvDUbcr0KjrFBb8NhSvxTCGldUQeI2dwqTILoOCx+AwFfkg3LHAL5LmgfXVyb2QnkS03Bjk3pZkfpTGR+wtBoFQr2/H0QJIxfrcUVvIpJnvKsDcXLTqYZs+8Wo/8S7R58sSlUtSXw0V5/nMi1aOwRBlTiIPFU3EubKJymoKcit55gsskdbllVhJ240o9NV3dOFDAQfgdo/PnKhCeY4osyk9Etjtk4WLeJe5rtUhqUEKp03sw3oT7FEdRW74ACC3zuRHGOBUzjEJgqeMDC73ebq+azpfJkdhYI+CaxEwER18cK4FM94303g6uY+t84YiDx1kGrOHeX9FObbqQhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ghwsdm4FGaW7ruVmooOp/Q5qPz0N5YpHZnOMrnwmMqaAVL7NTHWp+pmcRxghOpCCiTFxvUveLRR2FzI60WruE9eBnWyf0FqTvCuRqanXmII1cbboc3y782pkdMKAuUDD23GkfpZuKKPveIVjxXuDrS+EKNSRo1q2KkLxOGIhYduM56wGWYf9ePzs53dNn6fCJK819HkeO8mN0H05ZEYpJqQ3RZGzPBG9KoEhWhEHTu0OVovcWF1bdznSyETjvV0OAIivUBh41edF+DuAOu3GOIKAkbtfHGvavqWOrHNCcSWabWOy7xwLueGkJK3AJdLC52Xqhm6xGZwJ8yvRauwk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VaQTkCw5g6zdGEXzG/n0BdEgnBWsVGCRROf6KSutgJ9adXtuWpCM7qlOFt2mFHaiCK4xJop8r/KK75IHmGyO70/WIrb1fuXWVQ702q6iCCQT2S4Q5gI5NQcilvpR675tjre3YBJpceQ1PgGfoMDQRhsyrGA0QvWuuSJQYzoRCnA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:19:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:19:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/10] btrfs: raid56: Use in_range where applicable
Thread-Topic: [PATCH 05/10] btrfs: raid56: Use in_range where applicable
Thread-Index: AQHWUHdDxG9iS9gwYUahblw7vNBz8w==
Date:   Thu, 2 Jul 2020 14:19:22 +0000
Message-ID: <SN4PR0401MB3598250D4812572DEAF9F6F59B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-6-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ddaf0b3-baa6-4aaf-8e86-08d81e92eaf4
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB231748519B721A2F3E1D1F5D9B6D0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwJrEUeY9VkFIxUK+/tlnVKqrVAatRhIjcE/D2GvlSdvEye7qCODDI5152QUj+4PfYK84acGAEhJpEJV5YsYnCtNtPVyKczg0oKETNQz28EaQn9G0ipiSm9yG7BXjgk0FPP6+QsVlRIn9uReqnNrAxZLvjCxNJaZUMjp2Z3JEtg5eUCFPw7nnmGF/Vf5haXXJlILQdaDwpjz8LTw77zJQrISKWyKz53DJBL7STJp9rl7zmXm2ddrKnEXzBjihuMQj2u3fa2VZN6RQLXwp8WxChLWXCHF5T8yDeOyj19cHbaqlh1WMfXNkk+WXgmQxCZG7iuyl8h6fyxmXWONxe2F1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(26005)(316002)(71200400001)(4270600006)(5660300002)(8676002)(52536014)(86362001)(9686003)(55016002)(110136005)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(6506007)(8936002)(33656002)(19618925003)(2906002)(558084003)(7696005)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TdNXDqSdsMsugqZBbH2NwoqPYocozt0fkG87DZrKj+jtGTo6ll9RuAdil7CKV/0BNQ7tOuud09Dkn67JkQforX9w0eQ8VwW0FVqpUEx2U3eTg1/D7Gax9n8IUZ4gJSLhXuVKEboqJOWdOPUbI9ChOFolSxzzlXrNrp6ViDfmkc4e/37JBuQHlejDtUNqHJKtAdOc7G11SrilqwnL3WRKAbPkFcgE7N0GvQZTMGKbTay+3LvybZAWu+af0FRrRzswpmSMQo8beJhPOZxtIJeAMVmCLsHIdY1wx3vBHc02T5mbD7tC31Ieu41ZThlMjY1iClu9AiYP6pQzzB5u+pPQIXkHU307OEc+DJzISkxtWW0th5nmrvmsvDjtuRsHf4UyRh0iXG5g04vOHj+IBzl/T+XJHWHr9VbZRlRBq/GLPjJiQRLQ1xwcNjQvPVQsQRqABawabsWKNf/yUa/rLLUp1T5M96AXR1K6+AMHmfnmmwvtHv7N+rt2rIo8vf4izouL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddaf0b3-baa6-4aaf-8e86-08d81e92eaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:19:22.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE9r5Cb5PxcYqemCq285ZDRKMXPEWJazc549wsLhIrMicCRf4ktXZL9QHNh6wGxM9RqzAXeXNNvse0PRgKiIDPZB9yk1l9CQpPMa7Uz0N0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
