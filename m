Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4C26A142
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIOIsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 04:48:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39141 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgIOIr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 04:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600159679; x=1631695679;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Z/2enfUTecMjWA7+1TuaDNWHEakl8e6/oPRvKAmqNNSXYFzB4cbL8V+2
   LxCGAhfjySVvoJiGPNzGX0kmzO5hkDursJNCqIG74wJmwpGqTMgr2UkUj
   C0OlyJeBzassskoiWXFsBVtXfSysyrF/Q7iNN6qM0c1g95RRnsrRYAKvc
   Zg4u0JX4ikN70AX/1s4sLMZLuPhJedb8XTq+m2Vb/7s78ETRoLzKVp6Jh
   g+cQsTKIo7PK3eAvaS5QMFDsOAmWbWHEnXFDVYk6UVpGooQT6wQcQEPA6
   lN7azBsubdQdq6witd161RCA4NWBNC7UMKn8Jj/HmJ23VTeD3fPdBvilH
   g==;
IronPort-SDR: EYLgDqEecCLcwecngJ68JjnaroLlXKv8DhjuCV1PshyToaIBZONtj2y9wow6CvXSFfNXzY4h7Q
 03Rce+l3ybR6E2Y3tIZ6g8kL00x2nA+mwN43X2kKuhpP9Qplrn5q/7eA9MBHUkZ0KMr3rzLmvF
 LEFoGM0qB8BemclKLF+LaMNBomQfm33XAbJZdY15sOeGBLtRc+K7HdC3VdBs4hjdP7exqIxY9O
 p3fvPgtTWtfQ6MEinn2YU/QSOAYRSLndJZbSeunIXcpGZylvHb5KwVWeEnF0uGry52QH678TMH
 0ak=
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="147325553"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 16:47:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsTQG4paWUPSTXyE+bWrZLZ9cDAz24SYAfMkTJ04hU/LKFKuqsz6bPp/UPJ/0seLqgktOpDZL/jK17KMv1cfRZ9Bjm5g4TlwJYvXiFlXGUEcGsVIjIGxH34SRXrDJHeQasekRtXMeS1f0AbVxlDnBEKgEei6LwBr02n/9osyWvULzVjojnqBbM0O1EQnQhyjwUldO3Ex0tWXnJyRqT+p1OKMmJV+vcSKxTTzfYjZWZJQJIZAHWqMBQ8Gkdv08o2ou2MR271WDtJamYZOnSSwbJaOaqjRcH5Pxx0HucZRyuH8xyWo+JzimtgT2x8bk2bpD9tVUBIg9vCbw+e7ciLJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BWCcgTek0SSaWjGrBH+btCLM31Q7uNwR8IQ/wFEZejitflnEdLDIM0BWXQmH+xPFW1tLZk5GFbV4edF2wyCtTnMIMF3KcRN2Bh8pQmiNoCcAO/s1GW/wboD7/+OSTriY+MGqvQVcxy5OCpdnhutYEpwZNJhD898+ol+wTIPKK67FkUiWZhJfDCH+h4J6eA/cXtisDNbtB/xoMijMpFo5UvaU/cG7vFjxqsz1/ANTGh9rsIE4a0jux5I7TyuOHi4Aoucw54uzr9G07VkASjyKsJ17yggoX+Y0ogI7KOlfATgPz+pj0KNpo10feL3dq5dDDfIf63DMGk1xuvZX2rP7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bDvFIzMpYbVrRIv2/Wke7bUHERDuOMyYAcnBmwgS1vYkySzIrThi2yezEaXy7xXoZ4wRzntf6eX/Mwrr8asMPiptrNcO/x/r2FNU6237nKU0Yj5syeTSe/4GKYFY7AM3zNtJ4EqRDcevHarPJMeBm40kxmDnJYl9NpiXKycT0Kk=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR04MB0651.namprd04.prod.outlook.com (2603:10b6:3:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 08:47:54 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 08:47:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 09/19] btrfs: make csum_tree_block() handle sectorsize
 smaller than page size
Thread-Topic: [PATCH v2 09/19] btrfs: make csum_tree_block() handle sectorsize
 smaller than page size
Thread-Index: AQHWiyIeNKGOzT0PtkCFKJHqiCxAfg==
Date:   Tue, 15 Sep 2020 08:47:54 +0000
Message-ID: <DM5PR0401MB3591AB6172A232CACE86B7439B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-10-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f50afcf-0850-47f8-c03a-08d85954096c
x-ms-traffictypediagnostic: DM5PR04MB0651:
x-microsoft-antispam-prvs: <DM5PR04MB06519580F3AB7B068607A4E89B200@DM5PR04MB0651.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WIu1oQNfCEXoNfvLTQb655Ti8ek6zk5MqFira0MA8XwEi1kkJOJyoKVRtkm0ixG3wRtjy5D7aWP+aOGgVHQ8F/TzNBaB9VS9LHAAUq7Wulj4oqekEam1PiNd3kDwO2IaIh9eypfJnHuGu2AIr7mH66B3D6r+wOTvASIPJFkihyHugJiZrQ90m564I2AHQqMtmJmfOHvXLvJ4jjJjJRCgzPwkj99ojGMEYvmNZvsiU9JdOY1Ve1hnoA3vVSQIxa9t2W8ySWKCKXXZXC5vHQsAmmsCkcU3fQGDyKNty4WpwDks3soqxnNmqkTLMlxeLrK+UuoguVpPKs0nmOjq2Qo6bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(6506007)(558084003)(33656002)(4270600006)(8676002)(2906002)(91956017)(186003)(54906003)(66446008)(19618925003)(8936002)(66946007)(66476007)(64756008)(66556008)(5660300002)(7696005)(76116006)(478600001)(86362001)(55016002)(110136005)(52536014)(4326008)(71200400001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3QbKOhunsU6oRRfphHBTRkxea5ooBESO0EZCx5JIU/pDiL2FRJqF5Eh9KMyQhSEr3MDRc8aJh9768sUpSwvWcvNCxemSinWYHQyCpmFpydWtvVtmioXLCTrRh1hF50XbHWXZs7EQiS4xQQUwPZn4o3ok8zRt1MjYFNcAJsH6l24E+vEaFM+LudGaSmTcMh3LffH3GBQoqAd7WJkLIIFuTP9VTrZ4/rhIUrQrArZqm/2pz0IKFafntjOdx9NIzGnqp0gg60teMIIu0dEPfcAL2+w/VSrQXCoSly/Q3ojjCs9+5Eyb6ML1M4dXZ9J4ghJhnfFLwSlgYXBw1CMnRicbFR3BOAq3p+vu1rGGtBiamWgGahtj7zq0fr1DhrCyd0NAwAesWscorRUgUkAYXqWcd+V9dIU8ptU88Z7VYi+x0Sjh0q8ldFOxYfilVfgltBM2nQraRkuFqCnlETvjyQiIwMwbstP+3DvEnEdhHL5JwGcxdyr6RHZa/ZU3yea4E1Z9gvpqBVV15J1TRMmHmN7iLdF+oGdVllkCPjCfHURlMpQmUyQhkviHbAleuWYwhHLctJYTSvBLTt1AnvY5SrQVAF4L5TtB4p9Up0YwsTsIKPHm2pEqm+l3FqZIbWCn7UWGHMGxUCvzjYRMiT9JnVtXCuu4QBiEPek+OSAL/hWnYFyfYVqMFSztHPl3EBGwqXpPRNvgVQ23Qd4bUNG7iTAO/g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f50afcf-0850-47f8-c03a-08d85954096c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:47:54.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRsYjmS9u2Rw3ln6ZodS54qrH0Fg451H5yK23tn7srDF3JgtW/tcSBvyUVvDKCVlP4LXjx4/11NALCxQY3CZYnZnp+bTRHyU5UzQVr8/9jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0651
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
