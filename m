Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6776750F21F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiDZHXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbiDZHWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 03:22:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E799D07B
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650957573; x=1682493573;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=A2pq519xdXSsmEkhZBO8MaFdQpXZ0KijLdSraJpz0qo=;
  b=qMcZeKEe2x4Z9bSllcBCYShTpu7IrTaMz1JNAegl4xzws3baiUCmUe/w
   VsM1MHzq43/7kLJUsECtFN815GEYBDfBLql8YW1RSxzqaYAkGmd2hwWWx
   jUNtY141Olvf6qBwYSzSB8zKJbxC0aV78zIiadRusqtuNUyeTjVwP3KaC
   PLE8hcUzJ0D7JkSdWPuBu866aQRko3a12KhqMMZmQjgrfEwWf1hg5sYhL
   e67eyk/ObiP1BgJHeFFV21QFL+Qt30RJ7yfbf34Y7X+f+ln4n2gJRc+p6
   JoPFFLbwHgYmye5CjuYdJiokt2YFzBqpa2NzmlBqUazgc9zaBUs/u9t8z
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643644800"; 
   d="scan'208";a="303038757"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2022 15:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnJCg5J6iLTqff+oIwmANnvwi70p2Pbf87RZ0elY4Lj8k6QrQBgLLV29SGwWbCZpj2OWw4kIzQTEMnj/RKJO6oRUEUpW9OqPSH0TebBbDSkSqZ4nCSQy1uGsh/T2AQOomldm6UgPG5bqILsQc+6bLv5wCNg6VGFV3OcmzJH5Pq5wNMqFO2pAY1uxL/Sdusx4M7xwJxtRd7sLsAXHs+PNGh8HQDoB+49UARm1XLO0zBtEGc+jZIZ/knn0trccOQ4HuBHBWo/TONqDpfhd1BAo18X8wFT1EJzRS3geZX4xbCOnAs78B0Njf7sc0iyJrqjeaW/PqRpL9EzVTKRZ0JDpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2pq519xdXSsmEkhZBO8MaFdQpXZ0KijLdSraJpz0qo=;
 b=VvFD29EFIVE8ghit0Y7d7NLELFYM9rJwTm8k7dr6HQpclbg9a1M2S2tfvwEVBflDQzeBXxeU1cejKwlfLyhAowyFT4u/gQT9R5YQTtnCHT1kuevCycCs2VP2nVwkydATQCA8jssdC0X+Iop6rBJzz9iqazx4UB7Zstn+rsWQfKYpV5KzWYrkkOpZtZ4iO0pQvpZybuIRGm4ZzxzQYNKXCSZzaA4V+wDgnFwPtFtGBwXgiVZeZ+VT0VUh/XXddL0TEhKnNR6jIaRb1gZRgjJS86sV2NTOfZoYARUd8QeQjMOuYRpzc9bT4Amu8tFoRmx2vWqnZnwN8LzPm42wAVf9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2pq519xdXSsmEkhZBO8MaFdQpXZ0KijLdSraJpz0qo=;
 b=yLXJKQI+0Q8P7EArPYuQgV9Gfrjx7fzEFAtiNK9111ePFk0hb/Y0D0OemQAky7XOKLljhOHR9+BkcSEN+hAyv8HjWVK+yzdBsNtHmZ4W3b4Wjpc445mU0lG9XwUgrcfXPQPG0yitFZWF7R4QZx7mS8Rx5ilnAw+SVGlqCRhJaPk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7395.namprd04.prod.outlook.com (2603:10b6:303:77::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:19:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:19:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: move more work into btrfs_end_bioc
Thread-Topic: [PATCH 01/10] btrfs: move more work into btrfs_end_bioc
Thread-Index: AQHYWHoa/6HhxaFpNUWB5JR1qkUWLQ==
Date:   Tue, 26 Apr 2022 07:19:26 +0000
Message-ID: <PH0PR04MB74167550138054E46AF5C3FF9BFB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6536b81c-2d93-4fc2-9934-08da27551859
x-ms-traffictypediagnostic: MW4PR04MB7395:EE_
x-microsoft-antispam-prvs: <MW4PR04MB7395F10084AB2243E993029E9BFB9@MW4PR04MB7395.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBe9i9c8Jl4F3quT9uhE2WjwjUQjJ3Wq8+yPSM5GQYGgchfmlq9AvH0gyBaRYsjO606Ge2gCIrZs0kMvODtEsCkD4bqYRS+AhLizX7qzKN6sztQ/SMI9UtgJ8tre/0pFa+mWAYDvLqajS8PPi5cnSnP+DJWgcIWQy/lInSRDSI1g/yOEP2smfcHjGUMVZzfcoruLxyb9F/QOPcNjnGptz5g4FPIRV+xDEiIThvw7QKe6NEw1lMW2Gz/HKDkL+JSLJQkh5fS2mW+yVnfU7wvb3PF/VbEwaWGWuwhnLcoALUVrH7zMVb+/Ot7+7lPJdCeVwpQTq7fdEid3Qry4RtNj8RmS4TQ7ql6BcGijeafKMDC6sJjDauvw4vJFLY/pcc6gHYwyJlD2U0AQvqiODilPK5knu7zeEru8/ZMBeyOSDIduZCOHmBfAj5HHB5c1wIxyH08o9BhyR+nCgSETeuiz8IDma+5EOcOtH+Qdc/N0QCAp22bvBGOU+6BCB5nts6nVUKlEjTOAFadUovN7UjOE9/9LOioj2mghNrd64jRtncRdOSCGTkIDtFwn8RnVeFaopN7UEvrlyH2JyHrF8NyacnlmMYp+PS2M2gnJLD4+tw6EvKzuwginFIlVW8TGN5897Jr4rMtv3yu7gFTwPWSB4gCpcVDcbWhV11mTHsboD/M6h9ugR6AYwNfjo8Pg3Piw+jDK65jAg0Kors6yz50CRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(5660300002)(2906002)(66476007)(66446008)(66556008)(66946007)(64756008)(558084003)(9686003)(110136005)(52536014)(316002)(8676002)(91956017)(186003)(8936002)(508600001)(33656002)(7696005)(54906003)(6506007)(4326008)(82960400001)(71200400001)(122000001)(86362001)(55016003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qJ5RrX6Y+MLOSQx3au6j7qLRi6q55ZL6k2BDE8ZgRv1F1cjisi+EVbNXjWZW?=
 =?us-ascii?Q?K0ecJIEHWD/SkVrIOYNPGU3a1zDO3VToInqMGLZq6BcZGYM5YkpbQvuHPim6?=
 =?us-ascii?Q?AL/nBmmEO3f/Nw3bf/yD43Ttej8xWIRWoFsvaZLr5ClNPOuGzZABpHJ6kKCh?=
 =?us-ascii?Q?XmMhUOAtA/+wPa9cDGceaqMP2MMeehqRjwZElSEmBHrxuexT8FXEPgUMy5Je?=
 =?us-ascii?Q?Y0hcfs0Ywdp3OSdFetS/VpQKbd4ByLl86ONLSikBEQJvaWnODndUkEW/3z3f?=
 =?us-ascii?Q?yng9K9D6u4gLfWnyhz4Zid94rGcf0f5lcbsqJBBdYz5ah6ppY3q61DwcaPw+?=
 =?us-ascii?Q?JGPag121APYQZe39Otb/TJZsBNTAPx6XvUGYuoLm8LoYubW/DD+/TqUCCJVl?=
 =?us-ascii?Q?pdv86RO4q6SsSyb4cxknwi5FthdCkhcogvjPJVTvd6ykhk2+G4tVxVCZphMm?=
 =?us-ascii?Q?HXArdSEHQ3iY019ednf9TRB3SlmkkSUdnEyChUMOhnOJW9kNafxxSKmE8ccS?=
 =?us-ascii?Q?T0srNisjFGfHdctwBJZeCitWhP8fCkKTAq+efq53ajKVZ50iM2zxQ6S5tE9Z?=
 =?us-ascii?Q?jt6tB2LzFKi8hb5NXo8dq+RtY+CMRjm7s+8IZJ16LKAyga3BbjB1pfBxM6Yc?=
 =?us-ascii?Q?vT6OQZPSRNeG0TMaXp8Wx4T6Dg4cfSAY8kPdLACzF1GlcodWI8M+lzRXrgAe?=
 =?us-ascii?Q?BPh1fgGsShiRnzvDuCRCFQjBSVa2aTsE2uZu6wl+a4p8c/o2qGvxicgENd9F?=
 =?us-ascii?Q?xSezi9JHOzfe1AgZgUpimpN45Xq38HGHUQXokc5F18gKbcbmuu9ViFKhsZ/l?=
 =?us-ascii?Q?0ddsnZ9nxj1iL7n6xML5oZHftoWgIkcBeHR3nkadzH8Wf8SrbM48pTEcbOuI?=
 =?us-ascii?Q?H9DAhah3PnBg1ovy9wPKrKfuqpG4okqCTrdv3JVZ689VwEVNlFgn5cmvgjM4?=
 =?us-ascii?Q?q5qbWEVHhbTWMeq2QChcljHsT8WH6PPed5x1HznAQ+Tq1FF0LpnTkzEAvZtB?=
 =?us-ascii?Q?4UNW8UYyV5M+qZq8ZuEqegHhJQVPeLU4th0HNxCpJre3uuWMx8wuPi56RChY?=
 =?us-ascii?Q?IgmdZOvVOQuKjIomOw0D276sf/5BOgufLfBT4LAGm0fkpC/YdfuIBHeWa7rT?=
 =?us-ascii?Q?uKGUU/nk9YVKQ4z49ofqfsoESdeHTI5qhounmC4ujohKvf3ocvWF+I8rorQG?=
 =?us-ascii?Q?h1KfEYGPjvSLSigCwc7aPlhPfkEvGADElYcm8/uDNviIS+bSpaPt6gDycDu4?=
 =?us-ascii?Q?wiVxupGUpS7qKD6P/XEM2X24ZMI2iq9QnRU+djuy1LrkwdVfqGuGkiBgaNxv?=
 =?us-ascii?Q?IFEFCCADt6rAVD3IJ3Ms2WtJvgtB4Kax4YW48dh7iC2RqAMHb5Lz+iIzbiXT?=
 =?us-ascii?Q?j8iK59b6+UpMY4ZfWHTxUmbln8/ToMhnTcWKCL4mRACwMQGR4ApRf644G/Ts?=
 =?us-ascii?Q?ZJLtQ5mooQdsI9h1tJowIXOm18QGot66WPDAW/mnEzRZuK2fEnd47R1Klir7?=
 =?us-ascii?Q?p5/QIXvZTmrg67ZH3cVPRFu1iIwl34G8MvSpGOtHduTBeV8jwW+zI1g7jlVr?=
 =?us-ascii?Q?jQzcm1nW0vsurZAl96U3pHXI8PbQR/5XXzNX6QXfsP6GoeCmVGpJhRZ8S0Hf?=
 =?us-ascii?Q?mfI8htcUXLYpSLzyWtplu+CX2Aj4R+jC5R8CHopDMiPEaCJjZv3rP7t0WMVx?=
 =?us-ascii?Q?G/1b+SUC3p+3572LCK/aSlAcrOcjABXnhcD3Hik1efNlYumU75Jk1y+f/BLf?=
 =?us-ascii?Q?bqXzoprfs7phuWFIltX03rrhaZx5MCQO1O0Z2QnyjcIVLLvM9NsPAY0+IWg3?=
x-ms-exchange-antispam-messagedata-1: jknMFNFoQ5UsrtRwO24r0ykS/sRbo4dP28pH9L3RcD8IEYg3iaguV418
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6536b81c-2d93-4fc2-9934-08da27551859
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:19:26.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yieYCqEgvnF6Zhr8og74sDw9s8MbieiMmlTFvX2ar/ZSdL5YQv077RnWeDBCjMbHEvE/N7Xh1BJ4SDSSUFKPJGbhCBmIQnmrEcK9xEs9iV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7395
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Meh I guess I need to rework some of my RAID stuff now.=0A=
Anyways, the end result looks way better with this.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
