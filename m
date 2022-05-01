Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861B5167C7
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbiEAUaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiEAUaO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:30:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAE41F80
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436808; x=1682972808;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rM9qgA0q4qk4y19EpAhsJSfyfU7RrFFJtnmLZ+37jsOfpNFLiTS37PrT
   VcJLJS9VnD5f56kuwkv/J8dV9bHYw1WVVmYF5rUnyDIvIqRJ4DHd8CjX1
   yMdrS5FI5F47dNkKXB/jK66rmOVcB0/DgDuoH+eToYbE0lDh/xEX2ySSN
   OPkYWAo7UNzovwWIHpaAa0Labe+hXYWVDHVcIFGDNIuYJq82AwE8fHxGh
   aO16OkfPQAVEUMBk+X+cC1FeP+jvbIPBvADgmOp/+Yf+WbtOu+65RVZqt
   R1jr6bzd5PK8G0DHRP7gRw/lgTVGqpb91vwK8g5slOatu5OM6h5E5TdAW
   A==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="311261252"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK6F0VCbXHLm+hagMP1ktPoq5z/VutzYQmSxPwRDy96LwTXSwUKvMuh/V0OSVrKTCsdAr9KyJtpW719GWE1LmFWHMwC4XL+LQDfh2ECAgZtdugMVVAON3yC+fGUAQvq4hd+Qo5IjT0Z9QIMJX1742Hvtg4mERWaD1iFpCKj+TcqVNSEMPk/ELYvBG32EsCx0ZoFX37WoLBbwZipttEG8KREQpv17d2IucNYPN9xTL8A6d1EQzbhK0TPekJjNChiykDbKWIhpSh3SKG53OAedVFv9wPgd+dxW6YLbpGpx8iStZvAuamPNQsR0lLIqNOoCZcFdVfIi7bqkWjwKa7op5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dwr+OYvdgi8uxK4nzav2klCaHj/O3+KCRnDnPrxd4PdDzrmqfFZ13RqUIch4AFdAeq0sd+V+wmcGmOs0XoSh9kZ2wuHqXJyu6PI6Gn6jp0AnNw1U64h1gTwP4isdeTT+JQc+MWgkaqsI6G/2A+jxrU/PWQivPydD7XwokRg1agXh/XVl6TQLcU59Rz+8vI6R/BefUqiKRHrF458sB0+yW0AjFfLoLa9DnNncepPMBYMHSsWZWO5ybXszJv25CoGavZnD1EXfa/tmB6tveaPY14dPy63ijOg3VMa4Ug9jV4ziS/nhCiWyl5fe1ScEC4TYvTSilDi95XDr8SnuEko93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FeH87qDRAW0Ywj5xetjqi+KY5rO9kRMM8/zaUSHj0+eGUmfgD9yRirmje4qXysed6WCnqy12Vdzj6zmvlIAp/2cEYQYIFoSDc/rIvWYHCOtoGFveK2YN6lKsLHM/ulGu/6R5olZasisBo++srRrqTWDd8oopkL7MwArr3IN2pjI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:26:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:26:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/9] btrfs: simplify handling of bio_ctrl::bio_flags
Thread-Topic: [PATCH 5/9] btrfs: simplify handling of bio_ctrl::bio_flags
Thread-Index: AQHYW/dofxNB0+k00Ey8dpNu1j5ZaA==
Date:   Sun, 1 May 2022 20:26:46 +0000
Message-ID: <PH0PR04MB741625578A472D986C9D0C6E9BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <53713d1b4ca97a63b046f1f256b43dc5d4b26a8b.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb8b90b1-cd13-4c08-a40e-08da2bb0e9f7
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB6689660AB6772EC66FA073029BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEMu99M8nnjOjMQ23t0UHtvfjRZ1ctV4MdjP8+pecDvJaDx5yg/s8G/FBGSmuB/NxhOoVPf3sft45LhLhAMCVluHMnMBuBSEPls3HerH1ZngsvJQYkbS6SXN8Fe3EKWfM2Z7F0SilJHwUirO3ecrIvZueyYr0xnjUOklPXLJYo/gOz7NzEby/e14XDdjX3yJumG0xFLafkoVQE0sLELA6vrTrszlJ3hlrMZAkHQbk10blmLx/miIjjs855960BOyw/flOB0Yp99aChZH73WVQLhurb0ejWoWh4lbxTX8SvyMCloMVjcKyClx5nUUd3Ow9OBzcrmg3TCaqePw4Ukq1B5Zl69F8ALjRKGPDbR0IcmkAm1uvpdGnxTch32ECzAIZ2ivimGJhpD3LzK449S2GAqssnKloOpF/C9bXZ0ssaX+PxbMbQlwnfpkQMLTYAqCc3uOS9fqA75QYMeqOy/VmXLnRuilqSJZ5xra13WzWt9zyNNgKNLt9Wtb7NWNa3fzmv3UWUxt7YFgvaShG8DmVUxAgoMo8KeX+F9KsFt++b4p22tHGDlfjSbAn+NzPpKGwsUJWG7xuGflde88mgp4EJe8hIc8UlHuRBJAMUCYBb/mknsm/G4/T0uSFy2lOSS2IMXv+5GvIuU6eCCHUUhRMYHMvMXIgAusFAuySWkcIQ+tzpMNjT/U4sb6HxTvBjfbt8zKtw0laPZ2oTIA4NCr8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qh21qTV4MpH+fO0mDYjNA2nvyO0FZdz10BLGXckerWH9npNoCkv8wfNQke7F?=
 =?us-ascii?Q?FdrPuXQVtd6Vw2QrLe62YRamLwqC4n/iKcT0Ul80h1hDkR2Y+OZz4KbJXnFL?=
 =?us-ascii?Q?08gIRV+J7ojpCEhudujWu0YOJheqEfjyQdsYwkZClQhv9Va5Gpz1H+nXA92v?=
 =?us-ascii?Q?z/L6TB4UiS9UEjZC4Ek8VnV9cfkEeUVDlOiAcfQp0wtBqFMj14DYFZb457cU?=
 =?us-ascii?Q?UMps0pobjh30mvAB+Ymkenk4qp5pjcsuaukA06AR+lCys8iyOgNS/sEg9jHv?=
 =?us-ascii?Q?TL7C1aluuU5gjiYnjioqrLQpW/Tz18QDVlKPnwz7wXnuAdzpRlfStXWgrgt6?=
 =?us-ascii?Q?LNu9PSJV5coU2cC4R5WbID7YT2kNhNcK4dJ4aMd2D3ctN8SWqH7yhQ4dsj0E?=
 =?us-ascii?Q?rTmDj6eAg+kbklYm5B7oC1L1mkdR9mJwU86nmHz/i8eSoTbcK1KQJc0O/0KR?=
 =?us-ascii?Q?Zt3JRhv9GeyFP0MOipXUI1eFZdxmr0GpcznPAzpBo/kB+KDPjw8pOITYWYYd?=
 =?us-ascii?Q?sX5vAnpROhWyZC7gaTwwLwhF2qOuQl11FjV+vuo0ZWqq6oVCPxeeMb3mFuqA?=
 =?us-ascii?Q?9BfM21Ka4Cd7bVpmiJ4nlbA2Jg2FtkRzKth4DH0RyoZrRXfotHNr1tLiYAj+?=
 =?us-ascii?Q?ra2gl5tkaxyGmrK9GkAUsV+BB7TdAAuYoIGSy1GkwGCCOoWw9fE69I6LVQHg?=
 =?us-ascii?Q?3ZZ71CTV+7T8DIdtM3/914OwR2eNTcBhaALTvB9tVzrECEsqfl1DvytAqzXo?=
 =?us-ascii?Q?BFiVT4h5yRDpnLhivUjbnWqfb+B+36yzyVN4eSggP8jEFEvCdjqk6d5Tzmpy?=
 =?us-ascii?Q?Gzl//iLeFLG4fli3IYnBFxlNck3+KDvmdU6MSnUeIJYkFZhLy6VKrEae3ggd?=
 =?us-ascii?Q?9TB5iwlAP3bINPbYQqumpq8SOVo1U4muUtFHQPstHb6p+8ncENbpxff5Q8Dk?=
 =?us-ascii?Q?QAwP9+jUEhLEz4liD2QnN+a/Z5S6+cyXH1nAbVm5/M4xwSKxn2CH9fRngiLg?=
 =?us-ascii?Q?qRWcJfwWbbMM0OyfHhPQ+mWaZISJU+NFMnB0bRHlQO1ESRnzMBk6c1HbajMZ?=
 =?us-ascii?Q?vCpQb4ZTJKa3u5UChQJgryRDwG7HlV0kHdXvUECVqAvLA4qWWoOJvNKJRt7q?=
 =?us-ascii?Q?oUzqnc/28rvxxnpCXuoYgxPsD1VDV+vkP0f0Lkn7FYuW9Qr0GgAYwDfMT1Qu?=
 =?us-ascii?Q?MgKdb4A7PF+zyIvGsFHkKfbrocTN/qtbzRjK9rVkDX3g0pQ0fCJeYTBbvrwZ?=
 =?us-ascii?Q?S0SGiWx42TVUcpM6Yr/S8pfetqNulQNOnEjZJt6oMuf0TdtdPwChnnYwfpEW?=
 =?us-ascii?Q?9E3p/3fe9atdTAamhJP8HwIZg4BrSt6pzEjNbud3fMDXOfzGvjopT3gNhqJW?=
 =?us-ascii?Q?IpuWsK9EAEgcu7Dg1zWKVF7zGiIUQGo0j5NqA6ccqUMbiJJtGhcwjsCmLdDQ?=
 =?us-ascii?Q?mppwevV8UMj4h0dyBusDAZN7KhJWfq5QKVi8Mu+JVcJWd143eaSURgesmmr7?=
 =?us-ascii?Q?cKYpoDit4TaGiDZrfvOWfgDwRFDeQJc6zpmbGOLFS7D3l1fQdrR1TPUx7qfa?=
 =?us-ascii?Q?8e4qNOgSR+CS/kq3WZIaytU3rY9iT67EMfGXZ16Um1vjjqjlP+UuU+ZKHXbx?=
 =?us-ascii?Q?O1NwTYD9zBdNVhqu+FOuTngQylaCgnjL+Ngyi7+XrxbWKCWEYopt3/58rjP2?=
 =?us-ascii?Q?A+KNo8jx9jpokWAYqz/7gGQYn7FmF+rBL8rxnNbmu89sK5YF5ApU/6ZPRhmt?=
 =?us-ascii?Q?dJpJfQO8kIY5aHcmSaVQjSSKWzfPMyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b90b1-cd13-4c08-a40e-08da2bb0e9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:26:46.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIp+rVQZd0+Gg29d0w0bj/8uf/9pmAwmwOGewfH619w+CQJUxXOy+HHrt38TJIR2x92VxywJlkypTSU8mKGICSsTspaT5YXgNRY+cN5dDX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
