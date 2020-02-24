Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1716B0A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBXTyi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 14:54:38 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63715 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBXTyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 14:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582574078; x=1614110078;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aNK6CEDROMUAvT6rps3KS8TAuT5xUPUNXTFHPr6xM3c=;
  b=dbzy/SAx4VBcCkO3xK7KY93qiwAaIE/CUovxt491Vn0cKiqtFjm/vWko
   XnrxnjumoxFT0mY5sqQoJ2HItK17IYTmhYw4NiNzBUUFF3jUDCNq1Phpy
   1cpHI4XbyajH8ppm33FgZaH+uQ+kZRWtc7TJrhNLVuUL2qmGiGEEgUebd
   u0VWRltD3J7q81TVbYYJXOgQgLkDXJHJ/klx0fLnTsTgiZpq5kWXhrPk1
   CIyC1tSWL7kx8HcMFrrZRTzjNNMOfpY/q1dBu/q0znjzWVu5VpRGUe+vo
   wJ0nBduDETmgZRXnNNUzOZ/hcJLbTdW3NJjSTYxCD3chWX/EZ4/wFRsSX
   g==;
IronPort-SDR: IYHZg5c2aabtg/uf1kRuopyK9Nff5lCKfqXITjw+boKTs7ySO7ZUJ8M4puLjrGH3thaWCvu8U0
 lFbQqg+0ZCublh29hDegQHz2wa0C9BlrsNjfy39vSEE4fyEtfr+smjunECor3HGuFSC0Iz2paL
 xXvppgM+JYM7ac25Jn/Bv8aXD+W3WOIHKgcpHE9V0jMYh5ojiT31Y+RxxeGFQXPMYOkT2mr22d
 SS8FAYi29FEvuNTE3bif+dNuXsCM2wcfOqeWF5YntjNkacFDbk5tRHcdGqhITGSDQV0RhYxOyq
 w/o=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; 
   d="scan'208";a="134995859"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 03:54:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhpJ1I8HJaKHUWC/osP5kg1ZDHf3w/lCIZgJzFLfDuEb/l6opHogOThw3afdgddg5vMGLqwlYZHlAOGaSeH+tDhTwEBAoqyH3IQyPPHQrnUc1tH/DsY2112Xds3vMr6OFHZdtGO6HL/pkuqXr+Wt8yy0tzW+1gDlkFBuG4RUXsPrR6v4PyN3IUKjbzlp8ughgad1FL9q9N/iBkKMY1kqHKvhoehztOUPC/osGKuxf6htwbEuVUpPQ4aDl02p41q4IAVNi7DLpwJIXer9NULmA1eg50S16HVnTN6ue0n4UbVrNFCGr3Q5UF3c+b0mU7dzr9brzFJ0ggMeXH2WACc49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNK6CEDROMUAvT6rps3KS8TAuT5xUPUNXTFHPr6xM3c=;
 b=hS1sCUctIM79lkCFFL4kJBZaqMaK5nKFWxHY2J2EZe7Wv7KxcBZmJ1//wkvsNZW8ybMUrh5C/VO292XOBqy9sDXFgIIyFCbWiIjA4UMxw0DpttiVFAJze6nOYJ6Qzvw7OJTf1eiKwDQocwZZKx0uGQKeiQyBPaML6N99zJycoSRnVGKhnMNXM/z3IWjqoqUA7GfWZJfEk1V3sMw2/W93M2NJ+YAfd2wgToANgOdcJdtGNba374/vE9arVlqQZ40+VF78KDQus8de6OwTvveUZA4L4YsfQFN6LEG++bxIrPTPF/SDh71MYFZf84VeCb8Rz3UJ3yaHFzV6lRPs0IoTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNK6CEDROMUAvT6rps3KS8TAuT5xUPUNXTFHPr6xM3c=;
 b=JSMUna/ydVFJ24QlkrRxnMD6lyzDKTAh9Wr5gm2pjy69iGBU2b3U6m61VsO2CAWYn0nQ+0IduGKfXw7JOePPReLVv3zo3HlAoZGln07b8r9hMdgxV+9kfAPOH5I6v7PJq9OPDQaIrnnOOtkJ8Oa3Tb8+7//4HNIA93RfXTxwvs4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3568.namprd04.prod.outlook.com
 (2603:10b6:803:46::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 19:54:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:54:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "guaneryu@gmail.com" <guaneryu@gmail.com>
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 1/2] common: btrfs: Improve
 _require_btrfs_command
Thread-Topic: [ fstests PATCHv3 1/2] common: btrfs: Improve
 _require_btrfs_command
Thread-Index: AQHV6sM58cFYT90+b0m5VAGvAfidLQ==
Date:   Mon, 24 Feb 2020 19:54:33 +0000
Message-ID: <SN4PR0401MB3598AE156240BCAA89AF186C9BEC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-2-marcos@mpdesouza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [4.28.11.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7db0f45-bd7b-4bbe-9d10-08d7b9635ea0
x-ms-traffictypediagnostic: SN4PR0401MB3568:
x-microsoft-antispam-prvs: <SN4PR0401MB35687A1D2C63113047D43A0A9BEC0@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(52536014)(2906002)(110136005)(71200400001)(33656002)(26005)(5660300002)(66446008)(64756008)(66556008)(66476007)(91956017)(8936002)(66946007)(76116006)(6506007)(53546011)(86362001)(316002)(9686003)(4326008)(478600001)(81166006)(558084003)(81156014)(186003)(8676002)(55016002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3568;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8dQqrZz39oC0PPT72dYIWc0gKfc2AKH35aEhnFMRuNHmZy5BHhbz/xAIp5zARqJ0uNoK0jrMDQiKAeW1/pSW1bSeD2WCWubGNPkiyh7H/zX4Zyc+cJeDjqmi+5SJ1L5fJ9Tj7TB3YQ6jx6k4snTJtE6/Vn7oaXNyNcaDu8T/He7VMb/1KNByWrQZR0aSx34MvBub+11kIYlgy3LW0Ou7Eij/zfq0yL9zhFmYjLaaYyDbDtvbhb4Avxrpu1zPT4GtqUX+9Wp+gFViAZF0uoO7uTNtEfiwaJ7UaWjfeHaUcZRzplgH9EylcVzA2bKSqKj5+SRkNUSUwps4tu7bodyzvvK98u9/d2Oz8uKkb3wRJuEItgXkka77xXOYKqwANLisauc9M5QvMoIgznamUGI/QV0QqGCI1lMCO9w4M6aLkyAj72Nht9Vs0MmTeUagnAs2
x-ms-exchange-antispam-messagedata: Mg6R02Lpiiwqp1PtNth//R1QFDXs7B/vAXi3jtHYtIjTncrtwX/w4GcraaPgyH6p/x3gWVtOHMVitYvENbTifFGtCBU97nT0bHhTtkeXQeslY35HgyuFO5j2Ux974O1Eqt/aY4pZLL7An/sr9B78rQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7db0f45-bd7b-4bbe-9d10-08d7b9635ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:54:33.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzTEcPEm+QY9VCLV5umAhTxehfcb627TIKjSX2DgTccGZLXung25GmFtcGdJQcS8hfJCy+EIPPVFyWS1FuxJKWJfnat/s9LgNsJs3kWZoDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/02/2020 19:33, Marcos Paulo de Souza wrote:=0A=
> Now _require_btrfs_command can also check for subfuntion options, like=0A=
=0A=
Nit: subfunction=0A=
=0A=
else=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
