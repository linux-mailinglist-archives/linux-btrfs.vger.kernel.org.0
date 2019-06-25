Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2B55404
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 18:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfFYQJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 12:09:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbfFYQJA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 12:09:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 993C4AF2D
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 16:08:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0FD1DA8F6; Tue, 25 Jun 2019 18:09:44 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:09:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Subject: RFC: btrfs-progs json formatting
Message-ID: <20190625160944.GP8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'd like to get some feedback on the json output, the overall structure
of the information and naming.

Code: git://github.com/kdave/btrfs-progs.git preview-json

The one example command that supports it is

 $ ./btrfs --format json subvolume show /mnt

The test tests/cli-tests/011-* can demonstrate the capabilities.  The
json formatter and example use are in the top commits, otherwise the
branch contains lot of unrelated changes.

Example output:

{
  "__header": {
    "version": "1"
  },
  "subvolume-show": {
    "path": "subv2",
    "name": "subv2",
    "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
    "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
    "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
    "otime": "2019-06-25 17:15:28 +0200",
    "subvolume_id": "256",
    "generation": "6",
    "parent_id": "5",
    "toplevel_id": "5",
    "flags": "-",
    "snapshots": [
    ],
    "quota-group": {
      "qgroupid": "0/256",
      "qgroup-limit-referenced": "-",
      "qgroup-limit-exclusive": "-",
      "qgroup-usage-referenced": "16.00KiB",
      "qgroup-usage-exclusive": "16.00KiB"
    }
  }
}

The current proposal:

- the toplevel group contains 2 maps, one is some generic header, to
  identify version of the format or the version of progs that produces
  it or whatever could be useful and I did not think of it

- the 2nd map is named according to the command that generated the
  output, this is to be able to merge outputs from several commands, or
  to somehow define the contents of the map

Compare that to a simple unnamed group with bunch of values:

{
  "path": "subv2",
  "name": "subv2",
  "uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
  "parent_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
  "received_uuid": "9178604e-e961-ef40-a5f0-2c109126b209",
  "otime": "2019-06-25 17:15:28 +0200",
  "subvolume_id": "256",
  "generation": "6",
  "parent_id": "5",
  "toplevel_id": "5",
  "flags": "-",
  "snapshots": [
  ],
  "quota-group": {
    "qgroupid": "0/256",
    "qgroup-limit-referenced": "-",
    "qgroup-limit-exclusive": "-",
    "qgroup-usage-referenced": "16.00KiB",
    "qgroup-usage-exclusive": "16.00KiB"
  }
}

That's a bit shorter but makes validation harder. I assume that the
output would be accessed programatically like (python pseudo-code)

---
rawjson = output_of_command("btrfs --format json subvolume show /mnt")
json = Json.from_string(rawjson)

if json["subvolume-show"]["flags"] != "-":
  print("Subvolume %s has flags", json["subvolume-show"]["name"])
---

so the latter is subset of the former, without one map reference.

Once the json format is settled, more commands can be easily converted.
