Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF1259098
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgIAOVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:21:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35893 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgIAOUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 10:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598970051; x=1630506051;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iitLIiqvDjptYh01st0IA5hffKoytQLsqPlFwC9vvdg=;
  b=T4tQeOpehXEPB5dwNPNlasJnJMyErMcuDoucMh4VwuDDRezo0K/HjyYj
   LvO4PM8nFnyBxBhLXCmHkry7mynDg+o5VB+ceaU//md2jOVHJFoSmnAG/
   +XMZZ1n4/w7N3ZiIwHLp0cStiJxBG+xwSQUvgOR0lUdMkmyFjpAxogiRn
   wQyb1m2u/6uyTqU77guAH8+Ju9a4SJz93KqbaCB7f+KpHig7WfayjmZL5
   OiKoGfAJvAjsMLwiBIIBPvQn/yqsXeZ1Cm+DNzkLku5nBhcPbDaWbTvfh
   YtTQs3KD0Na7Vu23bQ0UPmEhB8wBqLlj3uUAKhDp8GR2XbW8WXODm+rVz
   w==;
IronPort-SDR: sLxBFK95UsFSIQIYY27rZGIbiTHF9e+6wjgr/EwnaAyJ7p5Gbn/kz6cU56FriYuGZzGRpPEidy
 MgskhpZT8RxGPjLYs61DYkHRAI8Mm4i78QXTJRDyT9Qq+PzhP8S3rDWXkyO1Qf56cm/wFpSe3Z
 FTpcS6X4rU/0a990WUEx5Ypos+BCkF5iyur7mEJ4UC3l5VxDY9WYBCz0UDti9nJXNX7OIGnEM9
 xa6+pCfyXfC0P8K3MIEItC5DK3J380Upwqo9sGtLNXBP8oMCnBWGwkI9UMdsnxEQUWDozjTI0E
 Pk0=
X-IronPort-AV: E=Sophos;i="5.76,379,1592841600"; 
   d="scan'208";a="255848033"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 22:20:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcw/1l9w7tjLdiFrGsGbJWhHCwIF74KnPVwzW5eGMYoXKDGQQ83SE5i2aQzYIbumdExRuN2WF/zm4BchEyeCPjErQHYqgIcc2k77yrrVtSyFw7+SidS8jBZ8udYv3hZbAZ7vE/k43Q8EKFpE3taIeiBTcbHLzwvrY4plEVD+NbCUm4csCasH+jBtE2d6c4Ab1kDKqfrL/Xve3L/dbmXq+xULzmrU72PqmFDYGXtrdi5UEpiJg59ScVGHtX63XQjuvgLBC9CfkHV6pEXMg83z/a+oSVgqHRWbs98obCm3bJFGiFjmteQcv5kddpCWmLt1rk6sJYZ/iDCMgu50bHiNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iitLIiqvDjptYh01st0IA5hffKoytQLsqPlFwC9vvdg=;
 b=UCB5iVng7Cqc7XJ5AG70lUm/QdK8rXe+YJx9R+tyvnUoeAU42FlU/Ij5j3Iykz+ozvsCpOiRsOF2cC3/L62IGY6JQQUq+epdAM0q2avxgYcrZH9Nbw6ypdilE3OTdODmc4+sQZer1EU5vw+mjIlydvlQDm+kIES+LeJgs9DfXaKJ6zQ+LHHHqlyHe4L1bS/Q5pYHqcZHb2gxygvAqbCH24Qp3uAqOpnJCZG9ibXSnTCJLhS321BrvvBH2O4eWz3DdU6npoXc22p08IvxBtzDMjFgdoW2pP43uoH0p9VeFX4aLicBrzIpfCQzh5VOR+b75XKdzNbGaGA2o40D8yKdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iitLIiqvDjptYh01st0IA5hffKoytQLsqPlFwC9vvdg=;
 b=s+ckC8SFyxLMfecE5seAivEDXbBjoOjQ/7FtdciG3uCiXUFhUT4p3aXHdqgcs5I9F3iirdYKyBTx4/9adP5/IGEgbaGwr10CanDrGTNO4HY3ja0YU1k8IN3zs+FOlq/gOtSXy9UqG8FNJU17kPvYBXI6tPYM8BupWdPM+pKwJfA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4463.namprd04.prod.outlook.com
 (2603:10b6:805:a5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 14:20:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Tue, 1 Sep 2020
 14:20:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Topic: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Index: AQHWgGDIsm2Q9fFDf0qcho+qy+MPJQ==
Date:   Tue, 1 Sep 2020 14:20:46 +0000
Message-ID: <SN4PR0401MB359823A8A58EA86D03ECAE1B9B2E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <20200901141715.kpemq765lwikdwoh@fiona>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f995fc4-befe-4daf-8e3b-08d84e82381c
x-ms-traffictypediagnostic: SN6PR04MB4463:
x-microsoft-antispam-prvs: <SN6PR04MB4463483F5FAD6D9EE3006CD89B2E0@SN6PR04MB4463.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfCOEBxyh+YlTR7MM/L4bUT+h1s48IhvBAt0+JuODhXKw8awj4tlKHOy6EdCJ0V4jkpUwmtOWt/9tvdowy+C7y8BGaFXhnniYFK61JW9pPZSrJ17kVn7O0xatEcoP7ZGhYDb4rvoXdRiuuTHnNcoM+F/uWOOoPAdL1LPip0TZOiENCJ7OGcsqeldvSwJV4hnkj4nRm+Dj+kq88yAwx4fFQcPT18IZ7lKZVJZwQULiN1OYUvYkvxw8zhd9E81E9QEe5IdKUlbx+1WADzsw9VB2ipq3drHxD/SNCmlCJAvo+JoZDIL2mWOEMWEfI9INq1tGyV//vii5wU5h1hZ8ZM3fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(9686003)(7696005)(6506007)(53546011)(4744005)(8936002)(33656002)(55016002)(316002)(54906003)(478600001)(86362001)(2906002)(5660300002)(8676002)(52536014)(66556008)(66946007)(66446008)(64756008)(66476007)(6916009)(83380400001)(76116006)(91956017)(4326008)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aMxKSvcGdi20uXWRqNUpAruGHtv5lEzCmRrIlbxkwGL5ZKymug55xUPMmUcnIGg1L413mTUDrjW8hkjXkDXmAyLmQTV3jPR5WhgWP7zvqI31lLQfs1u49Ky9iBONS6Gmyo4FY23dCrJsvrKp6BISSdTrtsQc0+nInWjMx2i1P7r8bjEVZ8jnhMXjOBCmCHennL/7cmkqq3xGYiG6VmxXMxw8yus30U93sS9sTL+3Oz6EuCsLmaSX2zO/DKOU+9dSXlqgM5+/O0xqp/0lmFMcJ29cZjS9u3EoK3Fncwz9qPe7pvl1+OPXfwDPROCfQepQ0k1eyjNYiJFvnQbUa5TR0WlhvP6y3nFCKjrWr6Bdv19JTnUkw0Y3zECiRZ2ConBbScoE7V4ibVWXoUfsqYfIgKV9JD+q5hLzDM5TI7yHsgCXfoWN0ExNZZlm4e7VNExC4KowPZk75qyHVXjjhwZ/qZmxddXC081b0SlbQu3RFjRYaqn9nZAV43UyWbgV0ynXYVCsbxdesGwWlzfmqHzvMHg9FPdbnViYCoAx7xtV4hcHih2VwNrJRTce8FfO05u4i/LufJh+9zxLvrnSF9IMIjczvOyDdBLO8X9Nj0f23hbwmDCuDkqypTbrb7Gc7n9j+DZtaK+R6+oZoQMWJYWqhP0YP+GVRiapRd2I1ZzCFKrgEi0375YVDJAru5QqfgXJu+goCJLS6jmTS+yyz+1YaA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f995fc4-befe-4daf-8e3b-08d84e82381c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 14:20:46.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShsThZMNhz4X0pzaIr/Xs6yO1Ndq6aqrnvQ/Vy5h+6YW95C9D1c0WHZaCIJ1jZP7R5alW7qUisPYTZL8IMKpCmXDB3n0V+TDM6w9+jsZr8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4463
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/09/2020 16:17, Goldwyn Rodrigues wrote:=0A=
> This must be applied before calling generic_write_sync() as opposed to=0A=
> after so generic_write_sync() can be called with the correct parameters.=
=0A=
> This is required for AIO cases.=0A=
=0A=
Thanks for spotting, will update and retest.=0A=
=0A=
The question I have though is, is this a correct fix or am I papering over =
=0A=
something (hence the RFC tag). Maybe we can relax the time we're under the =
=0A=
inode_lock() a bit so we can avoid this deadlock. David, Josef, Filipe any=
=0A=
comments?=0A=
