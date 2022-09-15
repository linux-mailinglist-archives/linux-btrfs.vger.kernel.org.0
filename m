Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF635B9D59
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIOOgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIOOfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:35:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D917E33
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252487; x=1694788487;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FoJxsS1o4lfsE+tDsDHzAGvGX2Wya/AqEIyhtalnjyK/5frUoRMzrDGR
   iI02pZp/x5IegaRml5gKw8VZCGEaoZDPQ14Jq8rvTLE6scdPzq85RdZYF
   wM+FC0IhB1j4HlJrsEbcR6DT5Hi3CaeQbX0PTVVPQGY3eir92CGgdyUFx
   6JukTxwcp3sF5Z9UzQV0eA4Jc+Qom4iEjusqqAhzN4pge4E3mxZZfvfHq
   kAFkfwBcKySZO3olGRnT3ekK5rMTnChCFciah2XI/uP6UQp/RLRs3iJ5V
   KaHGRK2JBixEMucbFPyNHpdi99FiFaW6ZQSCDbrLaW3MhKbIlqQ4sU+2X
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209841492"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:34:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKNsRpFBI8DaW92tFcwQk1KkT6/8GFeVUQlUzxYUXmkKBSo1kpECZn8f3nbsviFBA8Nuk5h7DX6zMlwU2SZogOnQkepdFqI/ZoqYfcJdjZuj9+OIQpkcg45CywcTn++nHDEjlcvF/X82rXv8y842Aen9LKrUxEkQjDs512aYdLMxKwvHc8/RN8nwJNQ1M5szihKRJJzL8EtYm/RvuE+hbTyCvccEcK610GZFWgvOprhnKHV+/cX80ZmEHRScUa8wTfaq62IL2MIJqkVguZuLnC9rPxLhlaYHmFJfRWxpBYoXp5Edecxs/CKfjh47YoIUfXKaJdBxJUfmK9ppX3dQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YQuvjELDVOI1/QJtgHV703/UzxXPoGMQikY7rHVdjN3LL8BLirUpmMa6XSQyM6CAVN93zyJ+FxQY7bYUqiSc/dva/F4JmJ9+bDbd9biDTABgx6hrS0ftvEHtFAX2zOvY74i56YxWPYLK45FWE66q+pFmHF9kZEsKxlCuXLOvXzTPolqRPUI/LEdzWndz6wkGwA2pT9fVKNB0ap4c7du2NPTzTuXXwUE6Ln3hAfA9iHYOz+AKU4dIcuo1HgcSO512Twz6MSlB581vxhmVH69lSvlGD8SWxdDuOZlSUcVxzYq/11t98TplQKxPrrErcR6M9zSpoXrwmn6q4gq7eK2qLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XWntNaQoLWc6TSUpKKYzARELoMVoQmmPbVzh5mM9ZxiXzO0omRI0zyrzza8IuTkBpdxb9xHduTI2XTUi9NjSOgiULmuiqMZFFY272MrlTM72/+C7ecPdy0FhMkE0Hrwuek4u6vypKj6C1jOxEXxFYKvJlo5qqpLQD8isoJ8YnnI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7125.namprd04.prod.outlook.com (2603:10b6:610:a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:34:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:34:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/15] btrfs: move btrfs_caching_type to block-group.h
Thread-Topic: [PATCH 01/15] btrfs: move btrfs_caching_type to block-group.h
Thread-Index: AQHYyI51BUmBYzOd0EqGD8PjTcamfg==
Date:   Thu, 15 Sep 2022 14:34:44 +0000
Message-ID: <PH0PR04MB74163DC36B51297CAAD0A9A99B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <84da2b1e0670313091a6ff604c105b09f3f18879.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7125:EE_
x-ms-office365-filtering-correlation-id: 144af5d2-4c3d-4687-2e93-08da97276f07
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5Wnop/BnF0tKWJuJw7I0IwvdnhWFsh2EjCpZOrdcrRGO1KhSQoQ1LKg9xWf7B1mUcCUwTma8QKeL4dtDGAXgrrCxkSnDTmlJtL1+zf6AalPdt0sXYujXbr6oEaIq+1PnAx6kmxaT5z8rHmymcsu4XT/do4TU8LFZhCPzNKOLiu8fkuUsTSXh2HDdGhoMsF84ZBkunSbHi3GmcFQXmRn9mt1X2lGdiR2hcWZNsgY4KaO66Z7YBfSUnU+4INBmtDdKp0wkc4LWi2LRhgI6Kxo2o+fPHZHlwoZs5BCqtC/vktp7bvRqGVtiJ4AbXQMDVgBdHiWA2F+hwut/ouGPjk3IORKn0cbPn96uGpuhD50C8q/eOIsfvn2th87W/R7VrMsu7wBSVhXP1MkfvUG8quIAlTHLcbQlPREIYkv/PKP+0AVu5EmUpgNEo6HdopH1VyROtJuhSbORokTw6c9CcidM/g3VJsQO3KWvKpCJnx5GkOCT2NQgp4sGtiWUvkwQ0maipf9Jpv+JFubw4YODJ5UVC0ZU8Z9AB4mY4TZXcK57qP94xfOxsAHhj/wWxwCxTE8BXXGYUPaAo2LYeeo3hn4kDl3vQGD6xg5x1TNDasKQBypsP3uf754eW/A6u3AUcCapjc9KtKjTrN2TcXM1JMMo67V9TpmA/rsg8SmajOmxeKApwZl6fsnalkClPIbQwxaqfK0akk1OhmaE+14CODFsD5KixsE6XxHJx0pJlLP3i+Sg5NIhBTbFCkQy4rPH7UCZUsnuqxCCxvra0ngbWEo0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(5660300002)(76116006)(8936002)(2906002)(9686003)(55016003)(19618925003)(86362001)(71200400001)(52536014)(82960400001)(66446008)(38070700005)(186003)(41300700001)(110136005)(6506007)(33656002)(122000001)(7696005)(558084003)(38100700002)(478600001)(8676002)(4270600006)(66556008)(64756008)(66476007)(316002)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sxLNuABrZIIXFyAWq3OGHqt+x/Pty+syiabvKBzGLTGM0IQOBbn8xikboH4I?=
 =?us-ascii?Q?yp3NmXl1I8NBSLGDrlp/qp4rZaGUsN3uCFQ0iUc+GwSiRY/18oQJjmaw8O6d?=
 =?us-ascii?Q?f+CTRY2Jsk9wtd1U1ThktGYgQ3ATKff6DUvOvkajEQmy+MJF6Y3KrIzzF1HT?=
 =?us-ascii?Q?qXGrqdjAdL2ZZeMqPrcQhN4y3FBKjzLQgvf/wHsZZvonsxkk7FoWQ5D7Yw2p?=
 =?us-ascii?Q?lqBZDh0Jdh7CO5rOSG3UeNzHYgcX7e3kgSS1+mkRgmDwOiFKopHRokVDw3Tr?=
 =?us-ascii?Q?KlIkL9TeHlRaSZGB65EbA/noCyl1Cl7XuGVN/nvczYG0OutBWYZO164j5rPN?=
 =?us-ascii?Q?3wl/yBnqAzZvKE+c8KUOoed9nAVwxgmKznKuu8vAuf0O2lmbPjjyNnYnKeM8?=
 =?us-ascii?Q?fLg8oij6gnqzbJQnwkqdF3X1D7AsIm5wKvoWP/YMNYjZPL3DtPHuqgMZTCDe?=
 =?us-ascii?Q?ajpXHu+fICKJF15llZsvfj0ljlCgHK7bRa9250E2Dt2ZrqiehoEaUX75V+iW?=
 =?us-ascii?Q?MhVJ1aFUBeYAkyqd2dt5XzMynW46WR72wWmjfDbXNAPYhhQveNLy4MS9EUDd?=
 =?us-ascii?Q?7ZhdTseJdk8T6ulrCgPqB/DJN3CpDt3l9nXFSNW30Y9I3Ni5h6zsNFGDvD7q?=
 =?us-ascii?Q?FzsGmRh8DdjZXZih+U0bphIEpsspW2hMRavn7E34PFKmMQe8ODCjKkamIQYt?=
 =?us-ascii?Q?Kzf1p4VxZqpYKJeiEqFkDtJSdGknMqdLcld74ZdGAUiGM9vJdwhrlcaEBcQE?=
 =?us-ascii?Q?MXvVHsst+KaoaiGVBYqcFcrknGOqVdYRhDH4zrIL24wWiwIzAS8HRxHt2HIf?=
 =?us-ascii?Q?ffmb7sZvQki4kqlcosMzCyj1gLMB6mGPdkk68DX4C+w2vLDJvy9h88nkrKB1?=
 =?us-ascii?Q?caBQ1UPEnqktWlOgJ3pz5FmFsia00ebyv24i+5BcfmxMC5JFnaCvlmy60LH3?=
 =?us-ascii?Q?eXPKciEX513ZgWQWH9J7qJYhwl6M3VR4A/O821ojjrXMNSXWg0g90BbKKHbj?=
 =?us-ascii?Q?AVqMyUA85wrrHzX0/Oa/84eePouzXJ/5+eUI9qYGIe1fvdQcB3a6Frrd9jPR?=
 =?us-ascii?Q?6hWzugxoRoLZtyge08W0cJKdAUtwjCNWIav4QBaWXWz9Pn5PTygLGhI8RFz9?=
 =?us-ascii?Q?46m0PO06YOzfEPNon96z3oxZFkrlQ6/CmxvEJTj53glYRRtITx6SGdcU1a3K?=
 =?us-ascii?Q?bTSXB0cFLavpBjnviTWMDa6kQf2HzDKe5QfRT+hjwdn3cuQGv1FJGNnZOhOR?=
 =?us-ascii?Q?dOVRiaLHoskbA6jheGQOXUtkVLY1rU+whIBjEBTrtGmlviVrr0FFUc2gBRdM?=
 =?us-ascii?Q?9hiAIUYoHYYDDvWKNj1bFKWJr2tRPh3bMcd3pSu1mmr81M0vVVQXRsrHEM3p?=
 =?us-ascii?Q?DYL7n09eABOHNtGPmRlQnPAPAyKELF6J5x3sDMny6o+ufVOm0AeUSBqBSeOW?=
 =?us-ascii?Q?Tcw13SvvPEDQk/dEgQAb9r/2xBcALewFFt3Aim41UmDZhjerdXeFbCjpr+bv?=
 =?us-ascii?Q?1qyHroved48wzdwKZRQVaD+ZePr0AxEON9GzqQo3IRvLAbkYVr8jIy72Sobq?=
 =?us-ascii?Q?XgDRhFzKcVfOdfyb6I6ozLEtQ9viUvd7Lcdg/h+gfrIXb9tZkwQEAtcpivu1?=
 =?us-ascii?Q?QLjfV9+HSDmLU1yshdEDqY6KVv/BQFI6q8C/nWANeucQQofyQ3RtHWTCv0bU?=
 =?us-ascii?Q?xoMhH1SfdywvU4UMylxvgWeJHbs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144af5d2-4c3d-4687-2e93-08da97276f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:34:44.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dvqj+VTkrNZ7JvKDwxULHxdEYZapyjDXxoSMbqGl8hNSydg0hjXjT4k3iTS0U6nUCDZ+oM55sTf1mPEIvRMt2rd/rcqUhqj95iuC5dgg0HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7125
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
