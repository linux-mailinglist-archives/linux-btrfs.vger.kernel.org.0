Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74728CB15
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389049AbgJMJey convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 13 Oct 2020 05:34:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgJMJey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:34:54 -0400
Received: from [192.168.177.20] ([91.56.81.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id 1M9WiK-1kVXxI29bA-005cvw
 for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 11:34:52 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: Raid5 Write Hole: Is it worse than in MD?
Date:   Tue, 13 Oct 2020 09:34:50 +0000
Message-Id: <em46b9d48d-39d4-44bc-9fd7-a08d9a96fca2@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:J7udtth/HVph8SFE2VC19POEb79UshrbT+9mvLympSEXcKIFkbt
 99yeXISK9XPfdhLwlM4O9CZkjkjSKLZx97+mqGta2J59+NPix3XmuMSgpFNk7axkhAT3ldx
 g9vmNM7AvMxz2PB0Ncg5F1fPhw02/tBvcymlZoRQ65kuUnmzpCwyjkdr70Rk8h8OjIkZIV/
 3Uw99+uZgmniV1BTyAZMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YL0qcG9Pi7g=:rnzy9jYsrBecyMRskabV6j
 NZ+Ba/gzHQkt+SXLesS7PmXFt/SnpMo1QtJCmBzwvxIVgZFzxL9bttr41EaWk/eVMNEU/yTnm
 ocQDTKlMkYITO3VYhiospVIcQcrA6Djz3F96uH6kFjZJKjjtb/d5iRsxptkEDsOtJogGQ1gDS
 5FqtnduShFYB/s+3oy0VAy+DBHQiW+qduPO/aB9zQq6cL0AwCui8eUKd0RaFne7T/Jawmk+vI
 F7Io3+WMaRZOMDoJiamAXqnX3LRBWCqQK+A6u//dXcYpd7ZKyhwNXTn2pawqbBFhS+aQNQ3po
 3OhbgA0h8PKUw73unKwp/vaMxqwyQW4ALoKcD7ZKxWidHF4xK70NAfm9lJV4OhGL1g7B8xq6p
 mHh9d6G5ASGWSjf66D4v3tkBPzCaxor5pDAk2O3AnzqadfQd2plqui3m2k2BJQfaM7jdISoHh
 yCvI4G9VqQeSxvQ5V/DRtBKZrQn7Dgvj9yOtbZTY2lBtchD2C7DXP0igaqbcuqQ92mOZvpGJj
 vMfGxhinQyZkIswaUVGk/k/tXJk5GDjOKCLiE8nYwEuz7AQnZdGky8ZCTxvTG2bRZ0t966VRN
 6ZSzQjQ+y133KMVFKk/qBMWkavCghnqoVsaNIDWRtOLibqLv/+aOKiNKTzYbWQVPphMryHInw
 LRrm2Y2FeuEiBN39pPySG7k0WXItxF1rWVxFk2rDHZArJ2+0Vuts4rMRqm+Ot7MvwZQEo2GdC
 3mj5pGwe8cWWaTkngtQV4Xh6dqbW1GwPqMpLIlvwMAaXUDEuPvcTFKV1TlIip7hv9aVXxZ1Vx
 YjD+iTeR5r1yKqlMafSngtwy2Y6tUZjWPg8qFBix8OvwdE0Ej6WSZGNghb++rW/Nuh8Gmp4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I recently read this article about the write-hole in md:
https://lwn.net/Articles/665299/

Whilst the article is focused on the journal as a fix for the write hole 
(by the way: Is that possible with btrfs?), it made me wonder, if the 
write hole in btrfs is any worse than in md?

Regards,
Hendrik

