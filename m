Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500F2212611
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgGBOUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:20:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34038 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbgGBOUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593699614; x=1625235614;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
  b=Z/OwnMEgfbnmiYZqC6RDu7oheBV2zxIAHYvSfPA6aU31H5+I5wgRtzFZ
   0/EmfFxuf/xGpbN+veogKf8sVcHCAXL+TC+gGRa0cSj7vH9Y4X2b3P7uI
   eWuU6n6GweDXUr6NAU5GUMRlUcS8dCOy4rJiE/BmO9WwooiFkgJ8xcYOp
   McVhhuKznzFOquixqMKlh3cJTzVFntfiItW98ARqQ3lM7cbv1y4VT6i1y
   ARtKdVg9DkB4NMYrPVILphIIIFXMf8eCEJulpAnWrEVO9xTgZYEFdQXeA
   1sPlmlOvciEJ2Kh+xkF2LklFwjVt/RJMZYrJCcU0hi320pJEXepC81ysf
   A==;
IronPort-SDR: DmS2qYbBhCQ/M2NgCh4ZtfS6AOd/YGaD3TIFvITdkpu/oxZ0mctXeKKOofCw31Amt0cxJ+uvLS
 f78z9gwa1ViWpZqz2GiYR51WfCWCBtHyF0byCK4T88PKNg38bVPldQ3xPZolQS0fNVIByruvlB
 K1OLeQJa+FaLRMh8dR7l6RPsPVrUsj5sSjSH/2RdhX2QVBXzfS+imggdsOa9RaKkNUDKlxfVnS
 802Je/4o0coW44mJLdCQRZDy8awqqRi+++Ri3C/BJqlzGHH7zuF72sJpAH63js9WAmwiskS0t8
 lxI=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="141485957"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:20:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpf7PTPBydLdXNDULDo1ObFwclNu1UeEwtnURQC6vOBEB7a4K7hKjwOG2gQpEk5csfNPLT2a18Qtp2EkvlH2vxDsVTE3W5lcqQYKGM62JPtcw3jIM8zQ1KsAOdC8hTVmKSYy2JRHzbCcnhYKcfjJcECiuofPfJ1/H6+Cd1+JguqB96mCsiQO8BOSDAXXmfAXv0bHbEJT3fy7+hhSEyBknAbhSV35e97RK5XEjPgIaLIxKK6jk8IzeDg0onW2RG4QkL7KEN4uTCIzvbSQMOCpaE1L5AsjGXRcfRBg17Mj4+C9A0TJ/4PHpe2d7bqlXNktFNNK/BkB4LljN/hkNHVLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=hwul8FQLGmpeHhINjkhDzr1R0wV++f30p25SXRzjV98CqvztUHBGHTq/jeDURfKEIWqtzc+wbfqibO9pAWHyGglfGlu49Yhi9B9oMXVwLB4QWloS3mn2VTlhp6FdL11fygk+cRXCJAUWXju3IGOO2Xb0aMW6RZYzhrwFh1c29wb5wWZrN1ZoPL1uHvzY1abq4Nu+Ned+RuRjbwv/OB4NuR3anNoQTW1qx65ZfcQrCWS4RmiT3Y4oa7RwZ5IL1BcpFqPxvoFjTv/ie0Yj/EdtXJoC3Oip9a+CwNkNuRpL7DznmcuaTtb+bUOrMJ+PNvRJC+NAkeZb+VX7FOAyRKWUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=TQyOr2OhhtnzusU+Gbacgllza4kvU6/io9EDQG++gtPn7rE0VqydcB5zFBZZF72mH6aMYtj4Aed57FDg4BE/+hzN40HnjJapB0ToNfSFSqvE6cqt6BPiCqBbDa5i9X9XhwXvAM8P2XAOrRp9r2moIBueWEmDM432yGsSo0kwyjg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:20:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:20:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/10] btrfs: raid56: Don't opencode swap()
Thread-Topic: [PATCH 06/10] btrfs: raid56: Don't opencode swap()
Thread-Index: AQHWUHdKRxQcKVHHx0aCo4jJZVL0iw==
Date:   Thu, 2 Jul 2020 14:20:12 +0000
Message-ID: <SN4PR0401MB3598FBADD4E0586F2CB866639B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-7-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 154ac69a-8d01-4ee2-d286-08d81e9308c0
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB231702F56995851E6B4EF7AA9B6D0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV1vg0wvJkhJNCDhyr79iUygSDM0G1Ol41DVp/2MQKskdVA5xV1xkw78rwWTltNjVQ5xXFS26/YtZ2XNrcJ6Hdj/jhD50oeD0e92PoRkygq/9TnAHIImWLoQctiJ3WBKGYpHePTqkB6Q3bIEAgm+6X+/YBdl/jOytGkH0h/CPLUuOeoub9mPj6/B1lEmOZ1fVqtwemY9/Tdv8JvgyvjgyXg1UBlAmdqv02mUfisLbTjwliPxI7qljdTwhUPg1bdoEqW8mW45jw4wHeHuqxP/Jfaw5fWU4C/Pwuc0BGiNZW4pNzObTKoHM0aQ+aSqh4+daY3kgUan+jkofFa8GxmUBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(26005)(316002)(71200400001)(4270600006)(5660300002)(8676002)(52536014)(86362001)(9686003)(55016002)(110136005)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(186003)(6506007)(8936002)(33656002)(19618925003)(2906002)(558084003)(7696005)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QW+LDB/aQQYak+9O19eioedNtuuBHUr7d2BbQegqlb1uwODpRegbllKuiSSiJgoCjNdzMg/crRZt9vZS+hweCY8nAz55yPYqbKHDPYUHgbiMfCvMXvKEGkv33JS4EMFyPTA6wHUyaSsM6FtI0rAVptrzpSgqCdq+kdhj7qc0CkSiYKGgQrcl2NjgRztI3qZkiHHmSiK+CNACJJoy1up+GFdTrwRbtzDnsOhCgNxtrivpCXMUttD+ol4qiTJ/VD+jF/EK2U26MWqUY13Htw1LAXfjc2j1tlPNSspdzW8yTDlzf4P66jlQ1z0V1ofsGXscOoi3BDrh+pQJQ8QlHHHEq66YVWhUHybAfIHgrdstXSPxCLYvX83Wp3DAEYdCm5ccQvtG7P2itaKBAPIz9Qaf5lAPY7Uk/2fMKOqnmArd9xnm4McumjLHCPP9UjFmkQfF262iGOIMYvaEND9K+2sCaeikxs2m//wQYQwTu7wKcJawhCWZtmDKKqFeoyETBu1P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154ac69a-8d01-4ee2-d286-08d81e9308c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:20:12.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeyCTpuIUntMbE5bJrsiCPMK5C9CNCu9BPymwkEAuIWjVBRiUL1ZnR+h4uzPOnGIdlKQRnukcdkk9P0TnF/sI8dkY1wR08nyVvep1jVYFt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Easy enough,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
