Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28FD1C050E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgD3Soo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:44:44 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:42020 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgD3Son (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:44:43 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 14:44:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1680; q=dns/txt; s=iport;
  t=1588272282; x=1589481882;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=AvtuId535pWzNKqUpDejhL19C6aIR6GcqahPTSDk/Wk=;
  b=gzfzT+BUkVBhgghTLSotIfdpwbsS6VrvU6Y7YSS1gEqPd25SQ3tikW4x
   d4fxIlFhgwvHQRN8dVk5xZNMNOvQU1Jcc6UtpYi/JgomnuuEmoesQTDCY
   6tBxUP3aLbpCxhA6YdfoQYs6nuKwur0YQsGLcEzoRGH2TBXMbwLXVwtZF
   0=;
IronPort-PHdr: =?us-ascii?q?9a23=3AlqReEhVCaXU5mOfpdkfu6fLN96jV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSBN+FuexLhvCQsK36X2EEp5GbvyNKfJ9NUk?=
 =?us-ascii?q?oDjsMb10wlDdWeAEL2ZPjtc2QhHctEWVMkmhPzMUVcFMvkIVGHpHq04G0MFR?=
 =?us-ascii?q?jlcwl4POL4HsjVlcvkn+y38ofYNgNPgjf1aLhuLRKw+APWsMRegYZrJqsrjB?=
 =?us-ascii?q?XTpX4dcOVNzmQuLlWWzBs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BxCwD2Gate/5xdJa1mgQmBR4FUUQW?=
 =?us-ascii?q?BRi8qhCKDRgOLMppDgS6BJANUCwEBAQwBAS0CBAEBgVCDDYIZJDQJDgIDAQE?=
 =?us-ascii?q?LAQEFAQEBAgEFBG2FVgELhgoREQwBATgRASICHwcCBDAVEgQ1gwSCTAMuAah?=
 =?us-ascii?q?4AoE5iGF2gTKDAAEBBYVIGIIOCYEOKoJjiV4aggCBOByCH4hMM4ILIpFFoQM?=
 =?us-ascii?q?KgkaYCh2CW41ZjGCEb4sgnRYCBAIEBQIOAQEFgVI5gVZwFWUBgj5QGA2QeoM?=
 =?us-ascii?q?6ilZ0NgIGAQcBAQMJfI4/AQE?=
X-IronPort-AV: E=Sophos;i="5.73,336,1583193600"; 
   d="scan'208";a="760058408"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2020 18:37:36 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 03UIbac8013522
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 18:37:36 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Apr
 2020 13:37:36 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Apr
 2020 13:37:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 14:37:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3nUKHiNAzdCl/eh87AzTcSkZeFIYEa+4syOeIz04ZNaZ/wy0QIPejK/hAmYwcXAXD364DNIsBGQE/zZOfVZVNisXz3FrJ3bBc5eu7KPl6xMRaLnQ/ICoOabQfN9Pms5wgbg/LUGQpfZOj8oafbO7tcd7xW8uS9+VPOasQGFkhWo+EK07vY+drdyFkhlsOvkPhMKdSf/aqTGzMotXaQGUDU+RE68Ov1/Qqu1GzgGjd5YbUIVsgRwhQZBL0eJ7iJMpfru3PM2w3RG+lfQVygyvlwuPxXgiaIRuadH26wZYwckWZ2R+I0NAI/RY6yv+dD8eNbhRMin1QrVj+qNEeFFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvtuId535pWzNKqUpDejhL19C6aIR6GcqahPTSDk/Wk=;
 b=hJXxedW8kYl/UObaEmqn6HSozl4OPzyjXMSfDtlGQe+KwFrBFB65htUpw9zjTds5+ido3yDLX1ZhL/rsPBswt7vXGHG3ZtbiOiN7r0YOHFzHivQe+VCh4gDnrgLSpYULUIlPehvWBm1WcBeif4rL05osaCmQo/6yh1w3ZffyEKXh6luN5JHUGCCx9H4uEkiYIt9E3Xh3VQV3myVOYv7YjZ1bGT6cBIXGTvCg4hiSNzYQMVeqFh2bgJpuMtq602Dea3T74rR941EZwfz/IZ5Lb0+6b+CsCcCKcx7dpyk3dk2SOo1erInWoyCHxT9pJ+WBxX5XdtLBPxf4oMkvtogiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvtuId535pWzNKqUpDejhL19C6aIR6GcqahPTSDk/Wk=;
 b=mvZ3eH5GMm9cURqZJI7LSjFMI7TnxKu9qKD/U2A/X8kJ+3PgU/GcNPIOHAphbG79OFI3fWZSIAaEtPeO6xmon/ys6bHhnPB5J8RCvJWWRNggSG1EosBabJdvM5TUrBS24fswuhbDmlUbZUYUZuLV3A35YX3uujENItAhM5A28oU=
Received: from BYAPR11MB2694.namprd11.prod.outlook.com (2603:10b6:a02:c7::20)
 by BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 18:37:33 +0000
Received: from BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::459e:e317:d860:200d]) by BYAPR11MB2694.namprd11.prod.outlook.com
 ([fe80::459e:e317:d860:200d%4]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 18:37:33 +0000
From:   "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Can I create a new fileystem, using Read-only Seed device,  to change
 the ownership of the files in the seed device.
Thread-Topic: Can I create a new fileystem, using Read-only Seed device,  to
 change the ownership of the files in the seed device.
Thread-Index: AQHWHx5pprLSIBcirEyXF6cp9cPgPg==
Date:   Thu, 30 Apr 2020 18:37:32 +0000
Message-ID: <8B7A1A74-4AFC-4B85-AF99-5EEDBB3B94ED@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.35.20030802
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2601:647:4900:b0:ddb4:bd06:9c21:8ec4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bc395c2-4f83-49ec-2c92-08d7ed358bd7
x-ms-traffictypediagnostic: BYAPR11MB3558:
x-microsoft-antispam-prvs: <BYAPR11MB355870AE3CB9E1F6922A29A6BFAA0@BYAPR11MB3558.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pvbFLYWcCNJn7yk3EEOCewnv7af5Au1yXMAa4S5r342kQgyzDX6NncXjgRl+YpeN19mvX43UqiwmVdiKXqc5tF1GZxDaynTN+yI3779XKTdNUZEoxwC1iHOH6IVU4uqpCmqB6cxWJKRAXhaTDnIWJ1N0SucmhtLFbax3xOHdZz9cdJQtbAAIdgcVIUXgX1X6Jg/Mi0wWczCHzMTFUuv2TjwTI24ZE/iUGYDWmq/2edkQ2PwH9REq1gpKrKmB6USLKiBKTeYMIkbLOJPU17UqWp5i9b+qUSxLQ3o58jo/GUpFRVhKkWIvx5tDQhH2YFbHv+jQe6XUCkBYxbqu3IBqVfjYDSM56YAGYTt51r3quLPym/ydlZhpB4RBf6a/SsPGtn4o3syMNXgxofjXaIXc7hR87lyq6mDM3E7I9zrSmz7tLbU7fd5KwdKLKG7IqSD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2694.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(64756008)(66946007)(66556008)(66476007)(6506007)(33656002)(76116006)(316002)(186003)(36756003)(86362001)(66446008)(8936002)(8676002)(6916009)(2616005)(6486002)(6512007)(71200400001)(478600001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Di0QNJpWwnxlp4K3M+oKmC8+vY7kre5e3h2wP4m72VYYV+J1h/MBlFBnjhNj81jbfxQf9pTBhGgqXHdQOXefGjSl9D2uHVrseD0JAAhc4KUYH17BC/f0x69jWG2OWk9tUihV/N5Q5/RuQ+0VUxE6yWIG9q8GMgS04zD+xu6W3MdW8EpkgXR+3HJWnEUOnufgzKCz9xbf+Xftm2mIiOOIuHXbfD4hQyYn0Jy39kFpRW/f08+IJdRqjDj+65UuRWZOng25BaXXoc/5dmkXIOJB3EfTs+K4IdB0AVsXDVMk6k4G0ABDglMwm7Bm6BpzxmkN3HtrfSkfIAnUCPwLas5WrnIxWiJ7euQJhpVHW/g/2x/2gm6ajA20+2qR6RWONM+JmEGQ1/LqCENL27cLKJ/v6hST+cGXI/2L8XYsU2w6FD8cP4478NVkKPOKfoQQUIeMBUJmJ/YWf4mgvfPoVSmlO0+b+N5EwnPEfeLPs2djdTCk5alp2VLwczZfxI68WB7k47coN9/7kfbUx7598lInSYdsmHSYtC+nUgUdTdJiD/Dg50V8qBFLAaYfYExJ8BTpHMSU/DpYIZCragzcVroDmZQctVC4UZy5W1gTrf9Cf+6ptLjz/+uxd/lR1lAuY7SXF9IO1X0tCkYrXBoydUCGAevhsoyIPoXdlTV4Rjoi/NTQoZlcUxWJsvhAQUpjfcG5MedW83MshCPR9wo0uNUMK7AL7nEiOhQnngztw4vAJN9xryFqC5doSHAFAjFUSHwXJajfpSo/95gG90z42LIDBayKO8QSn36OGLcy0XRbO8hIB58ogJsMY1HHl4bqyZqb6I519uXEfbBT72IcAcgacfkU90T6gX6H1CrjJAY7zQE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <303408F932B04043A9302E4B41C29B64@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc395c2-4f83-49ec-2c92-08d7ed358bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 18:37:32.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRscBOfVXmxQIf3R+GDCzd7XIhEE9qi38A4WxNuKIBEpDi3Qnq3BoG/VCpAhJCC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3558
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SSBoYXZlIGEgcHJvYmxlbSB0aGF0IG5lZWRzIHNvbHZpbmcgYW5kIEkgYW0gdHJ5aW5nIHRvIHVu
ZGVyc3RhbmQgaWYgQlRSRlMgY2FuIHNvbHZlIGl0Lg0KDQpJIGhhdmUgZGlza2ltYWdlKGN1cnJl
bnRseSB1c2luZyBleHQ0KS4gIEFuZCBJIGFtIGNvbnNpZGVyaW5nIGJ0cmZzIGZvciwNCkxldHMg
Y2FsbCB0aGlzIGZpbGVzeXN0ZW1BDQpUaGlzIGNvbnRhaW5zIGEgc29mdHdhcmUgYnVpbGQgdHJl
ZSBkb25lIGJ5IHVzZXJBIGFuZCBoZW5jZSBhbGwgZmlsZXMgYXJlIG93bmVkIGJ5IHVzZXJBDQoN
Ckkgd2FudCBhbiBhbG1vc3QgaW5zdGFudGFuZW91cyB3YXkgdG8gY3JlYXRlIG9yIGNvcHkgb3Ig
Y2xvbmUgb3Igc2VlZCBhIG5ldyBmaWxlc3lzdGVtIG9yIGRpcmVjdG9yeSB0cmVlIGZpbGVzeXN0
ZW0gQiwgd2l0aCBhbGwgdGhlIGNvbnRlbnQgaW4gZmlsZXN5c3RlbSBBIGJ1dCBpcyBvd25lZCBi
eSB1c2VyQg0KDQpRdWVzdGlvbjogDQoxLiBpZiBJIGNyZWF0ZWQgZmlsZVN5c3RlbUEgaW4gYnRy
ZnMgYW5kIHVzZWQgaXQgYXMgYSBzZWVkIGRldmljZSBpbiBjcmVhdGluZyBmaWxlc3lzdGVtIEIs
IFdoYXQgZmlsZSBvd25lcnNoaXAgZG9lcyB0aGUgZmlsZXN5c3RlbSBCIGhhdmU/DQoyLiBDYW4g
dGhhdCBiZSBjaGFuZ2VkIHRvIHVzZXJCIHdpdGggYW55IG9wdGlvbi4NCjMuIFdoYXQgaGFwcGVu
cyB3aGVuIHVzZXJCIHRyaWVzIHRvIG1vZGlmeSBhIGZpbGVYIG9uIGZpbGVzeXN0ZW1CIHRoYXQg
d2FzIHNlZWRlZCB3aXRoIGZpbGVzeXN0ZW1BIGFuZCBoYXMgZmlsZVggb3duZWQgYnkgdXNlckEN
CjMuIEkgdW5kZXJzdGFuZCBidHJmcyBzdXBwb3J0cyBzbmFwc2hvdHMgYW5kIGNsb25lcy4gRG9l
cyB0aGUgY2xvbmVkIHZvbHVtZSBhbmQgYWxsIGl0cyBmaWxlcyBrZWVwIHRoZSBvcmlnaW5hbCBv
d25lcnMgYXMgaW4gdGhlIG9yaWdpbmFsIHZvbHVtZS9zbmFwc2hvdCwgb3IgY2FuIGl0IGJlIHNw
ZWNpZmllZCBhcyBwYXJ0IG9mIHRoZSBjbG9uaW5nIHByb2Nlc3MuIA0KDQpOZXRhcHAgYWxsb3dz
IHRoaXMgY2FwYWJpbGl0eS4gd2hlbiBjbG9uaW5nIGJ1dCBpcyBub3Qgb3BlbiBzb3VyY2UgZmls
ZXlzdHNlbS4NCklzIHRoZXJlIGFueXRoaW5nIG91dCB0aGVyZSBvdXRzaWRlIG9mIHByb3ByaWV0
YXJ5IE5ldGFwcCBmaWxlc3lzdGVtIHRoYXQgYWxsb3dzIHRoaXM/DQogDQpUaGFua3MsDQpTYXJ2
aQ0KT2NjYW3igJlzIFJhem9yIFJ1bGVzDQoNCg==
