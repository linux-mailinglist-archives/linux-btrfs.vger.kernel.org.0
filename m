Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539426F687
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 09:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIRHNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 03:13:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64534 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIRHNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 03:13:53 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 03:13:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600413231; x=1631949231;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sKVTiYQeJGUszfjwLfkL5VvJG/8Gs3egAp/vQW7GIhs=;
  b=qkFPU2xkyiPwf2BgnjvgB0hI5N6dyPI3XOtXlCmiswZrnmwkGVPP9+2k
   pLu6U9LecAFfNG93o0ZGaQ1CuYRHObZTUHVTMmK4j5GST1gOBfdJOUV4d
   xCt8iCS3xMCV6skZg9E+X1gciJPxZWARCYH5AzaA6kBJZmIQ0+iVjdVo6
   gl6L1YYpWlNLQBKLBukFvtpgLMAEKLLmBhIacLuM4Ag+eGXc+y70W28jg
   0STJN/2jCKSMNtNvVv8nVfBehn/w9Bsyz4rX3jJ72f7WrQLAUz6Jh/UzQ
   NQ33r6aOCS79Ew1Sz4T44XLSWTXt1BcocDeame4GAFViL9x43tg9nwvJn
   Q==;
IronPort-SDR: oOtL+O5LPk36xsirrf1SC7yquucvCpR+/LEDvLB95sYbhzhJm+w9q/ZI2XcMMn09s1lwegaOI+
 LMEXUbVbkwqz9ntuvVxpMRa426Kps1cfm1uKuc/WDpyetaVQ1pF3DeVHd35L9YK0kaEte7yYsi
 hjXiDfqYNDCFyg/1vHQgVKLm14kqIloJn/T2f85KkxY09OmPETKY9+oNwGydqAR6NHxsk0/W58
 G/mjPaoJa8muSduwZg/qn8gVfbHPYE0vCd1xU2KT3b0N+r6YKeZhPgFtMLCXCa4S5tlFAzmeog
 O0c=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="148937358"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 15:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUlxQa8QFFrHh83QGdREI28yVDqIbZtOThHnXGFZhkVzc4Dm8g8HSXW++yE/29L7JhDiY1jAtakXm6j1LzWIxyIjnSZJSuD5YOfD5zKnrqfEuH5srbGckn/Yq9scKHtZIBIH1VD/X7+sLnpNMP39u1avDcKA29B/xDz3Lk0bPHi5ih9z10uyuRNijrt9Gz/JcRI9rnDqm7nRGMfyNXPrFY0YuIQVlK8JAPLV5hNfZ2KpgQlgzKdnrGPNxa6d9M9Bk4ddD98LypjdgIND/UcgCymZnUxioGMjfRgXf/yEBux5pDTV3AS9F+hbqlAN7TbrCOg0byUNG9X82o1eHwLZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKVTiYQeJGUszfjwLfkL5VvJG/8Gs3egAp/vQW7GIhs=;
 b=On5m+jGcLMIdOgzJmJB8fNoJvmQ21s63R1WkrptMflJUciNg1LjekTPMXbvS5P5lnI525Wp58KyxwwcTBzhl4uljHcF+Q2K+x3n/Pery9tmbFzbhYI8+63LOQy/aZJMuqUsnmeG0ctck+OfzhGp8f9IBp53ksNFfqEWYV/I49gLeJ5mxd2DzF9iNttlJnmM7l8pvD0aAjFmcCd3AHo518j/4pwlWaXXJJMdNkEzF1PfcQSD7asGCd/knn1DlpIbUmCdk8H5LTj80l+J1CTqtwinvV+UbwvKGgOSwwYR9yKyVw1XI6Fo4rare2pQmac1Xgb4HsudHTzxrRlDuY84zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKVTiYQeJGUszfjwLfkL5VvJG/8Gs3egAp/vQW7GIhs=;
 b=YVBFP85bzXTDtwUJRYOqNW/RlFC7ytk+VjU7/hhcuqLj4CRecXPoemgE0Gs298OyTK1krnaLRv9VRG4i/j9kzWfXZvz7+yQHXM4FeZ5oOkBcPVNXsRnNvxq44MvDaVtKbao9liBYoeXm6fSUTNK+q6TOCRINl2VNcr+tDJvA8Lg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5166.namprd04.prod.outlook.com
 (2603:10b6:805:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 07:06:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 07:06:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove stale test for alien devices
Thread-Topic: [PATCH] btrfs: remove stale test for alien devices
Thread-Index: AQHWjPzP2xqtKbJRkkWsoQIT/o7XrQ==
Date:   Fri, 18 Sep 2020 07:06:42 +0000
Message-ID: <SN4PR0401MB35987D9F6868271DAD0A05009B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
 <f4606506-78a1-4771-96cd-6bc28e6a7074@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:8d9e:cb93:a2df:3de3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbacc1e8-60c6-4ff8-ff8d-08d85ba165d3
x-ms-traffictypediagnostic: SN6PR04MB5166:
x-microsoft-antispam-prvs: <SN6PR04MB516664CAD4FC7AD88870C6CE9B3F0@SN6PR04MB5166.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3MIwSZtJslEsiSwcPQ5KrHFPUevAshs8UsklGd1tE94hv7aG09vMStsVhIhBBfHRC5EJfrVz+tJIwlmzerJ2VWEP4ixUYZmX7xl/TpLAPOPeGjFXP4GT846tpqxJ4UyPC9A7K/O6qzi2TFkXhEogcVPOguPufJSQtKSm8Sw4pJ7oZg5yLEHR78Y/BfKArqKAbYQiU+BAgZAwoyeh2KgVFRAE+bnVwnukaNe2KpNaKqwcYB24/IH1EmCxkMsoekfg96Ay/grpNAP2HAEqfqWi9gpkz7vLX4LXAHGMvkIB0FQrhSA3alB66O1GIbC4tZe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(8936002)(71200400001)(83380400001)(478600001)(8676002)(316002)(186003)(86362001)(91956017)(9686003)(33656002)(55016002)(52536014)(110136005)(6506007)(4744005)(5660300002)(64756008)(66476007)(76116006)(66946007)(66446008)(2906002)(7696005)(66556008)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FpYWEtUaCVnpTT4DuksSX32zuzIrUP34u2oSg7nb+9PB9yg5dmtAl21xGw2RfcRgeo9QU5KpcCKZnkCJyyI4jLXqD6QUSezJ0xcGVcHF46pRQpBtS5iIowCvT1JhSc1u30aKEiFTGzNFX99KKV9s+u9j04uGhecnZy51Fk5qCHwXzM2LRnsPzSO1MDDmPodW9wL0akELA8iPvpVu3vpdBPBa4vPhbcFjITtQowqe+/61Bj0OXdmKVYKzPr6u+9ZBney06/gMQ0T7z4QMFX0qqzw690/g+yygZsp+x+0eSTUAD+b93Yb9TJCtzyKPmtP1KdvLqr8j4aQ8Cq7jheImFA+TSgRuymM3e847FqFDVyVhSpUc5qYkPMFlamEIdktZYBxAUT8XmXicfa60KeHpc6UdoTj6OpjE6EbPiWuvHj0m0qwHrcrpgXwgWCOk+j94iXDxSWeq6Fw6asCfyppn3Tz0Nlc8l91OXS+TfhtY6somJBs7mF1k8lVX0TsHe1vFFbiR1RtgYRHnXneaaEDLsFjCO+VJ9o+JItppLnVgEuvrr4lq98n6FxTmTHKqc/Mx/p9TF06hPTQf6q2yRn8TfmRBKAOWDLc7jQyJxhaJzmeIkEo5LGRlbkOiiDb2mRtF3AkFOmVWiP3rGRp4vOBOrTVzPbqeVyLKYuPc8YB41agF1QtVVsMEi0/kEszMFsYiPNPqlBZLj670T8MO68l8Vg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbacc1e8-60c6-4ff8-ff8d-08d85ba165d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 07:06:42.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPdzahjeT6X59mqacimuUNJWHF9viHT9zZCfJK8ADiNzmShNc2cxov6GIbrc54Fq93Zt1iCZ9iDzxlt/bqPFUVG631opu818REBJe/3fpAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5166
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/09/2020 02:15, Anand Jain wrote:=0A=
> The fix is not too far. It got stuck whether to use EUCLEAN or not.=0A=
> Its better to fix the fix rather than killing the messenger in this case.=
=0A=
=0A=
OK how about removing the test from the auto group then until the fix is me=
rged?=0A=
It's a constant failure and hiding real regressions. And having to maintain=
 an=0A=
expunge list doesn't scale either.=0A=
=0A=
Thoughts?=0A=
=0A=
