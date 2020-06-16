Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8361FBBE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgFPQjA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 12:39:00 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:44862 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFPQi7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 12:38:59 -0400
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 49mYmw378Nz4f3lwJ;
        Tue, 16 Jun 2020 18:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592325536;
        bh=bJXCLBv7BpCnI4RYTawCDk/vE2OpN5kV67J9uE68wPM=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=ODUv5LROdlN6qg5w90wUq62jeY4vQD5+lJ3H67YAXISIBkLo+KOZTyOqNhD7B0fmv
         sozRU5UJa76G9ttkWeQK2x8ikcrHbYJSjqh37h6xvJKp+usTsJBtbE7EgAXHWatC8d
         Bi/4rT/PwUx3X9m1Gg0/derbL4xTf/jLiZAOiB2E=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 49mYmw1nL0z30b;
        Tue, 16 Jun 2020 18:38:56 +0200 (CEST)
X-AuditID: 0a3aad17-4b9ff7000000186c-4c-5ee8f59f4144
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 08.35.06252.0A5F8EE5; Tue, 16 Jun 2020 18:38:56 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (fe-mbx2029.de.bosch.com [10.3.231.39])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 49mYmv5hRqzB1C;
        Tue, 16 Jun 2020 18:38:55 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2029.de.bosch.com (10.3.231.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Tue, 16 Jun 2020 18:38:55 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Tue, 16 Jun 2020 18:38:55 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Having troubles to disable inline extents
Thread-Topic: Having troubles to disable inline extents
Thread-Index: AdZD4YpxwA3ZaANaT02rXcz/vOG1Vf//5CCA///cyOCAADdRgP//wxUg
Date:   Tue, 16 Jun 2020 16:38:55 +0000
Message-ID: <3d1eb5475b62412c8232fdc09a62258a@rs.bosch.com>
References: <2e956e490f6a430f9aa82fed3c8be08c@rs.bosch.com>
 <e77dbead-308f-94f6-cd98-2abd524a863d@gmx.com>
 <fab7af8e7c2d4201b4e1a0a0cdbecda3@rs.bosch.com>
 <be4a51c4-b1e2-46cf-0b5e-5c695fdc9095@suse.com>
In-Reply-To: <be4a51c4-b1e2-46cf-0b5e-5c695fdc9095@suse.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.151.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42Lhslorq7vg64s4g7Nv2S0uPV7BbvH/TQuL
        xeLuNywOzB537y9k8li/5SqLx+dNcgHMUVw2Kak5mWWpRfp2CVwZq979ZirYxVax7vZ99gbG
        JWxdjJwcEgImEnOmrAayuTiEBGYwSVx+N50dwtnNKLFm3zcWCOcto8TEQ4uhMnsYJQ5cv8gO
        0s8m4Cxx/uJiZpCEiEAXo8S5RQfABgsLmEmsOrKKEcQWETCX+Lh9CjuE7SaxY8FUZhCbRUBV
        4uTKxWA1vALWEuu77zFCbLjAKDHt4jOmLkYODk4BG4n/p8BqGAVkJTob3jGB2MwC4hK3nsxn
        gnhCQGLJnvPMELaoxMvH/1ghbEWJtasbwcYwC2hKrN+lD9GqKDGl+yE7xFpBiZMzn7BMYBSb
        hWTqLISOWUg6ZiHpWMDIsopRtDjToCzXyMDCWK8oKbW4ysBQLzk/dxMjJKrEdzD+7/igd4iR
        iYPxEKMEB7OSCG/25xdxQrwpiZVVqUX58UWlOanFhxilOViUxHlVeDbGCQmkJ5akZqemFqQW
        wWSZODilGpim/b7zdVbn0dnftkhecTXSX+OUnZJ/+F5xT7iP0M2I0DBfq+MJBRW1hswJUp6i
        CxWn+a7//Cut/Fdv+lZ7S8b/3a9/Je+z9dGexi/V9uPaapX7J3ckCR8oXsOfnaW+6JiR0LTI
        RROU7226HlzLLHurcK6KU9TBuvxcm+7wZe+PnWgzl7l26kN2kGR7rffMn+FslhFBPfoHcmJN
        IrVVpnTI2qxN5Km+cu9+47a/t9iVgtZ8DJ5ewrtu6quW+Buf05/eCvx16Wfg/sM7F3hmGN/8
        GLL4tFPzdbZFqwy+zhAI+CfzYzFLkpPTJqY9izr+Xtk9/3iSx9/EhiMnJ0ewpIfqnb6pJ5PH
        NyN00oONxu+UWIozEg21mIuKEwF4d8q6GQMAAA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

VW5kZXJzdG9vZC4NClRoYW5rcyBmb3IgeW91ciBzdXBwb3J0Lg0KDQpEZWphbg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmlrb2xheSBCb3Jpc292IDxuYm9yaXNvdkBzdXNl
LmNvbT4gDQpTZW50OiB1dG9yYWssIDE2LiBqdW4gMjAyMC4gMTY6NTcNClRvOiBSZWJyYWNhIERl
amFuIChCU09UL1BKLUVTMS1CZykgPERlamFuLlJlYnJhY2FAcnMuYm9zY2guY29tPjsgUXUgV2Vu
cnVvIDxxdXdlbnJ1by5idHJmc0BnbXguY29tPjsgbGludXgtYnRyZnNAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSZTogSGF2aW5nIHRyb3VibGVzIHRvIGRpc2FibGUgaW5saW5lIGV4dGVudHMN
Cg0KDQoNCk9uIDE2LjA2LjIwINCzLiAxNjo1NyDRhy4sIFJlYnJhY2EgRGVqYW4gKEJTT1QvUEot
RVMxLUJnKSB3cm90ZToNCj4gT2ssIEkgdW5kZXJzdGFuZC4NCj4gDQo+IEFuZCBpcyB0aGVyZSBh
IHdheSB0byBkaXNhYmxlIHRoZW0gZHVyaW5nIGZpbGVzeXN0ZW0gY3JlYXRpb24gKGUuZy4gc29t
ZSBvcHRpb24gaW4gbWtmcy5idHJmcyk/DQoNCk5vLCB0aGlzIGlzIGEgbW91bnQgb3B0aW9uLCBu
b3QgcGVyc2lzdGVkIG9uLWRpc2suDQoNCjxzbmlwPg0K
