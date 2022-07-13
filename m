Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D21573A5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiGMPnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 11:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGMPnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 11:43:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443634B0FC
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657726998; x=1689262998;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CqGSBkKRoojmEU0Ma0NCeXVFGSabrS50x20IOX99UG4=;
  b=UWa48SzGoocr5bYRYZ6n1eBXCNVJJoDTmGg7IxeOPAOz8c9zsfmGwEh6
   nDX8NgUpHkK4Cqz6IYyj3jJmk6LJQmVJkIKBsOXtjloLJF0GjUPGjYr0k
   ydTIFa+3OHChRqnNpvzaZz+2riX7rGnidML7EbKTGYB9pYEgLEX0UTjV8
   lp99Mzn5OrRBtp62p8NaL6qVuBUTxQmvzsPCBH9DGk4Lb5ScE//ZP9nz+
   FcDkX19/JdWdcEBC7pLEM6T/tJeQ99DkHZsrIjHvXGwzZi4BYIWH2JfS0
   gQ2wvH2i0BI5YhOV/uuOWjFw4IbVp4wxo8rl9rRIVSDDTpHKdBx7aaQ+l
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="204251890"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 23:43:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0XYQoDA+k9N8otg+tyATtx++BkPVRngIfkvybbzeNr02QUfNBHIBj2IdGIynlUbx45D/iS70gcw9h/XlXxJZtjO9AtHQI4kuQoZPPORRAQEUgAyptUOqOmECedbtlQAjxmiMeaiUh2lz81ioLwMGjJGeDLG3C3gixIUUudvREz6HKQ3FwI3LOQdbINOq3vde2rqpxEpgxKlxy2vc2i+wWy4rrDA+03+joEtuh8Q3G/tLxRbHrRQ3NSh42MRXNiDzhHWb3EwOeUc0itgszXsyzPKNDzEV8E0y6K8z4FXuXOnHT0EYKWnHy+okCvfNWvyqPdF2GnfOPmjS0kc+lLFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDhRkhDhFfRt97mllYfbYfWdChEVM0yvogq/5isdy8Y=;
 b=HHYheVfVk+YgiehAxFPSnxjb8y7A6YkCkkPosmz4wzGhDCKw9Eta3VQZ44ddO0ZhjXRf0Bqiy+rtJosczSsHOtOKMGE6SLAMr5YkyxVPy0NkUrIKPAg3V1qP+kRppEo2KAYgFsuHhtHQNG65IMNlQE/OnJDCgLSDjzz7evD8B4pMpWc9rlwN1R/+YytwDQTHB2sVJc6d7Tzxmrda4O0fDyoHhlZ6eFaECIlBCbnaK6YwWWo/gDIWGlrrtZffHuEaGMMB8BN7wbvd87CW31ggbGpkBuf4/PhrATocN2UaiOtw6tHVtPISWF8p+3tspr8Scdk8n+6cayYXxAYhhESGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDhRkhDhFfRt97mllYfbYfWdChEVM0yvogq/5isdy8Y=;
 b=Zt9bCey//zCRMlOHHSDTZPy4kIMc398dFMJBlCSw4HfSEC784dsb4EzmGq797vvyd4BEvpcocwW9JAmm9XwrEyQydjv4Zw4MbiheLnZWEossMiY3ceRmY/C6+ulEnFiII5B5sm8yMBr304wp2ZXOTQkxHl67abV69zJeYWvEKnM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7917.namprd04.prod.outlook.com (2603:10b6:408:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 15:43:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:43:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Topic: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Thread-Index: AQHYkwbFK9lbodl4ikWp8TqJRWAD9Q==
Date:   Wed, 13 Jul 2022 15:43:14 +0000
Message-ID: <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 008ada62-00da-4cd2-a340-08da64e66661
x-ms-traffictypediagnostic: BN0PR04MB7917:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3KezF6No4fHqyUR7KjprRDPKPd7CznWVRmcTBP2hKvnce276hSxchRmRq2ofcXZN6378fD+IZiPYm90pCj1uNg+whLuGuuxdJlxt1oykxhHG7egCrYFpyYMi9sh8c2YxfI0xsdQoEUqt7YlQ+6tzjUGys11ms6DWjw9i4mU489gDof6ngGv6TDoJv12IeQwFZ+s2DfOgvK7zqIxY6zSaYxSvUmHB7vt4DBhM3FbUooMAG+7GtARGirhMqQ+5tf0lqRfbup+qT4aaef1U9YNd0LI+hjSAzP1B/xJCyxwmvYbhZT+ln1zQYHjNRxEvzbEPs628A4+Yj5dDfkewv3V74StQlQyUdVa6ZB0+ckHCqF9TaIFxxhf5md3hYvJyC8H4+d0FEiIxRBhrUI8yFASOXc1urMLjZwLgkSh3Yv+WhXdmbknQTpJ2sXKRXH/2/TSRgQLN9azvhyLQ3A+WPT+1ynptGMJuLm+CbeBhlDUnI38OZoJr6+tQ0LIIMPsG1Gz1BWz5M38cxxFVZJX/EIkRpyBptEidnWE7WwgvvAHHpk7sYInACpzgfn7gwEZATPK3jumkbnzcfMiHZ9DbWtnMf9JfZcVYGf7mh7qsj19giV4FnixwOXN7hed8o5NrgKfBqa8XCrDt2E0oC/8s75ZR7JTaXobrcYGDpeo4WprzXAZn7MEY7UhsDIMiAbRXvrw9V71lKTTvQAYmvEOk8NO5Uo2pyaKhv5T1n2FlIMHL3hM9R/M9N9VV4EWC8MwGbb+cRKk96DugHJn+Xktj6kuj5ZhCbNwvtHCFAjKM6Vdc6xytBmVPB1ZlOQ6aOtu55/H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(4744005)(38070700005)(110136005)(83380400001)(66446008)(52536014)(38100700002)(122000001)(8936002)(82960400001)(5660300002)(55016003)(2906002)(66556008)(66476007)(186003)(71200400001)(7696005)(53546011)(91956017)(76116006)(6506007)(66946007)(64756008)(478600001)(41300700001)(86362001)(316002)(8676002)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lbFz2Y7hZU+lE8EcXR1aXNWYct1BvFhl6cgXqMmG0L9HBjcsGZKvo3kgDfAN?=
 =?us-ascii?Q?PRFCzZ/OmE0HUrQo4bQ6PDI7R0019FYgcQRbHvF5lQ16cdDMp/RMO8BY37oK?=
 =?us-ascii?Q?oF6q1MmgGb3VF1KsK/F7+qhf1FEeb2zgJXH+ZFBfhCSrQNL9WpRp2/EwDKE8?=
 =?us-ascii?Q?NEfI5t43GaNdbfLprEGxc9+3cVgAyF/M5RceeXEdgZV4J0X5GQ3GhYsJqGdg?=
 =?us-ascii?Q?UVexXeXR9kFs6e7VKCnUQS3BvFDLr1gQ1/lWRXfYjKvxCrykxdrXner3Ziz0?=
 =?us-ascii?Q?YgadujbnH1Cc9uxhZsuLmrKt0bZ5nFtXmxRjriPFxzofDcJ0hm6ft+Bkpkvr?=
 =?us-ascii?Q?upPQVoIwKNEGb3aGzhJHnsYN2J2YgSPssjMHM6lht5vzx3kS1LdHiEzTk/Tk?=
 =?us-ascii?Q?qa2+S/wtI9ThthKhmiyn+Ykho1ggYMzMtfSQYySs1w9riM8wpHtnCZR7xINz?=
 =?us-ascii?Q?5IYpZCAI9clqqN6txP7o0j9saq0WjaU+UU+pYscv65GYxvHEdNskfGlvMKHJ?=
 =?us-ascii?Q?QxVPhdwOiymb4DgIax+HMXFqpZWsewOgCuzE3qeGv9tO/7roQWBxKPoWlTEi?=
 =?us-ascii?Q?JtqvSPDUB3vup2RAVqfKFrwhPI1YxFSZc2mtkhaXKJ98oMRzZAsRZe4/fUe7?=
 =?us-ascii?Q?vcFokcZk18Bz9Ll5ar9KzBgV64v0ZX9lgfKfHE43AqGNdw5ZynaI/EIm0Oek?=
 =?us-ascii?Q?LfoOvcO6Bw4OLr4yC76oGDnUgvKQqyylBsQ+RnzDrFUj6QaSVfFSnH8ejvPD?=
 =?us-ascii?Q?8r3uPmbVP5Twfv2L+ZZzLFoAbu5bBoz4547OyTTjjsck/lExO/992Z6M4G5+?=
 =?us-ascii?Q?L0MBMoeO8ZoBj05Qwk6/GCeWwqCP16gytZoru9T5oBKWONPpWPgI0YfDrEts?=
 =?us-ascii?Q?IOb1Jfe5mj+bG5C7e1DGkYsLbZ4vCYix5tH2BCK1j9OL2tKsKWnlzrdfOvkz?=
 =?us-ascii?Q?HymA9S5LFBCFTAnAwGAtj/gq6NZoA4Bf98WMFvKtEvKvmJPrcNH39XrjliQ+?=
 =?us-ascii?Q?ChZjko/PF8kcELc/Uw4c9lRD09KZWRn/1qiWC21/X+w9suV4VbwXkWCwh6Bc?=
 =?us-ascii?Q?SoBwkvymo144Zm2ffCHHpXdSOlG20N7FQWF5B6MBVGmTE/K/Q8v+qWkbZGdf?=
 =?us-ascii?Q?rxfZgpobYMRKOYRM7cTZxqjrPrGiu51F/1JPSl587Z58sKzLXljOQ/95/pVS?=
 =?us-ascii?Q?+jZ4hGJIhrZVl7yNint/4eququbISp2z+tu+lJyB0f7SJ++6mtcmsG/aIF5H?=
 =?us-ascii?Q?OU7eFHsLd0uTxsL2RzzGTAQUA6S9wnuwaPv1eV7UxDybYzoj4YIhgoTcr5Hx?=
 =?us-ascii?Q?sPmzHOiOKIYywkM3wKK9FEYptOxs+2/QzwwpQgK1SGiPTv119hgM6zj7qFd3?=
 =?us-ascii?Q?Por5npn9xkie2FVVeYLMezi6LakyURoxMhPnGDaTl9Ev6k+a5EEMLCd7/sE2?=
 =?us-ascii?Q?Dm/iG6eUQpmy/ifkd4q/ZJYPILIwooBsX680oLEYILtTNLs1p0uj9xDW8VIU?=
 =?us-ascii?Q?DuEQeDlbEATo1n307En7OhKQXJ+VQO4Ad2KLOPTy6aCE2CeBRQJCjWCULz5Z?=
 =?us-ascii?Q?y7oQZMiP5tJCRlvSQoMNSQ/qvBUpPgfo+oO3avWaKbp8yLIrKJalIMozaHAE?=
 =?us-ascii?Q?rM2veZDN3q8thY/bvQ+VtYMQzpeC5MUc4QAtlwbU+eOG/y86HKt0Ca3x2weB?=
 =?us-ascii?Q?Gm/wyrlkm2+gFY7ukvANyuOgYhk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008ada62-00da-4cd2-a340-08da64e66661
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:43:14.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 065csJJ7PM6H+yRcZll/ksy0FI1HxYDuXBqaP2OTFUiTARpyQsDjl2YLx+6yuW+cuF0enRg/mjCv7og2S7VGhYXoeTfAmYeJQ5nP8zhx7xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7917
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08.07.22 22:10, Ioannis Angelakopoulos wrote:=0A=
> +#define btrfs_might_wait_for_event(b, lock) \=0A=
> +	do { \=0A=
> +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \=0A=
> +		rwsem_release(&b->lock##_map, _THIS_IP_); \=0A=
> +	} while (0)=0A=
> +=0A=
> +#define btrfs_lockdep_acquire(b, lock) \=0A=
> +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)=0A=
> +=0A=
> +#define btrfs_lockdep_release(b, lock) \=0A=
> +	rwsem_release(&b->lock##_map, _THIS_IP_)=0A=
=0A=
Shouldn't this be only defined for CONFIG_LOCKDEP=3Dy and be=0A=
stubbed out for CONFIG_LOCKDEP=3Dn?=0A=
